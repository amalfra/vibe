require 'vibe/request'

module Vibe
  class Client

    include Request

    attr_accessor   *Configuration::VALID_CONFIG_KEYS

    def initialize(options = {}, &block)
      # Merge the config values from the module and those passed
      # to the client.
      merged_options = Vibe.options.merge(options)

      # Copy the merged values and ignore those
      # not part of our configuration
      Configuration::VALID_CONFIG_KEYS.each do |key|
        puts "Setting Configuration: #{key}" if ENV['DEBUG']
        send("#{key}=", merged_options[key]) if Configuration::VALID_OPTIONS_KEYS.include? key
        send("#{key}=", Vibe.options[key]) if Configuration::VALID_CONNECTION_KEYS.include? key
      end

      self.instance_eval(&block) if block_given?
    end

    # Get Data from an Email
    #
    # @return [String]
    def get_data(email)
      if !email.is_a? String
        error = InvalidOptions.new(['Email(String)'], ['Email(String)'])
        raise error
      end

      get_request '/initial_data', :email => email
    end

    # Get Stats for API Key
    #
    # @return [String]
    def stats(api_key = nil)
      if api_key && (!api_key.is_a? String)
        error = InvalidOptions.new(['API key(String)'], ['API key(String)'])
        raise error
      end

      # Disable cache for API key status calls
      get_request('/api_stats', {:api_key => api_key}, true)
    end

  end # Client
end
