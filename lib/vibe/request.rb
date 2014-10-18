require 'rest_client'

module Vibe
  module Request

    extend Configuration
    include Error

    METHODS = [:get, :post, :put, :delete, :patch]

    def get_request(path, params={})
      request(:get, path, params)
    end

    def request(method, path, params)
      if !METHODS.include?(method)
	raise ArgumentError, "unkown http method: #{method}"
      end

      if !api_key
        raise ClientError, 'API key need to be set' 
      end

      puts "EXECUTED: #{method} - #{path} with #{params}" if ENV['DEBUG']

      params.merge!({:api_key => api_key, :user_agent => user_agent})

      begin
        puts params if ENV['DEBUG']
        response = RestClient.send("#{method}", endpoint + path.gsub!(/^\//, ""), :params => params){ |response, request, result, &block|
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
            JSON.parse(response)
          end
        }
      rescue SocketError => e
        raise VibeError, 'xgcv'
      end

    end
  end # Request
end
