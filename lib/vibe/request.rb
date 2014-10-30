require 'rest_client'

module Vibe
  module Request

    extend Configuration
    include Error

    METHODS = [:get, :post, :put, :delete, :patch]

    # Perform a GET HTTP request
    #
    # @return [Request.request]
    def get_request(path, params = {}, cache_override = false)
      request(:get, path, params, cache_override)
    end

    # Execute an HTTP request and return the result
    # Exceptions would be raised based on HTTP status codes
    #
    # @return [String]
    def request(method, path, params, cache_override = false)
      if !METHODS.include?(method)
	      raise ArgumentError, "unkown http method: #{method}"
      end

      # Is caching activated?
      if cache && !cache_override
        cache = Cache.new driver: cache_driver

        # Check if cache present
        param_string = params.map{|k,v| "#{k}-#{v}"}.join(':')
        filename = Digest::MD5.hexdigest(method.to_s.gsub("/", "_")+path.to_s.gsub("/", "_")+param_string).freeze
        response = cache.get(filename)

        if response
          return JSON.parse(response)
        end
      end

      if !api_key
        raise ClientError, 'API key need to be set'
      end

      puts "EXECUTED: #{method} - #{path} with #{params}" if ENV['DEBUG']

      # If API key is passed as a paramter then ignore the one
      # set in config
      if params[:api_key]
        new_api_key = params[:api_key]
        params = params.tap { |hs| hs.delete(:api_key) }
        params.merge!({:api_key => new_api_key, :user_agent => user_agent})
      else
        params.merge!({:api_key => api_key, :user_agent => user_agent})
      end

      begin
        puts params if ENV['DEBUG']
        response = RestClient.send("#{method}", endpoint + path.gsub!(/^\//, ""), :params => params){ |response, request, result, &block|
          # Go through redirection based on status code
          if [301, 302, 307].include? response.code
            response.follow_redirection(request, result, &block)
          elsif !response.code.between?(200, 400)
              if response.code == 401
                resp = JSON.parse(response.body)
                raise Unauthorized, {:status => response.code, :method => method, :response_headers => response.headers, :url => endpoint + path, :body => resp['status']}
              elsif response.code == 403
                resp = JSON.parse(response.body)
                raise Forbidden, {:status => response.code, :method => method, :response_headers => response.headers, :url => endpoint + path, :body => resp['status']}
              elsif response.code == 422
                resp = JSON.parse(response.body)
                raise UnprocessableEntity, {:status => response.code, :method => method, :response_headers => response.headers, :url => endpoint + path, :body => resp['status']}
              else
                raise ServiceError, {:status => response.code, :method => method, :response_headers => response.headers, :url => endpoint + path, :body => "API Returned status code #{response.code}"}
              end
          else
            # Is caching activated?
            if cache
              # Put into cache
              if !cache.put(filename, response)
                raise ClientError, 'Unable to write into Cache'
              end
            end

            # Parse JSON response
            JSON.parse(response)
          end
        }
      rescue SocketError => e
        raise VibeError, 'SocketError Occured!'
      end

    end
  end # Request
end
