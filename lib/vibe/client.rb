require 'vibe/request'

module Vibe
  class Client

    include Request

    attr_accessor   *Configuration::VALID_CONFIG_KEYS

    def initialize(options={}, &block)
      # Merge the config values from the module and those passed
      # to the client.
      merged_options = Vibe.options.merge(options)

      # Copy the merged values and ignore those
      # not part of our configuration
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key]) if Configuration::VALID_OPTIONS_KEYS.include? key
        send("#{key}=", Vibe.options[key]) if Configuration::VALID_CONNECTION_KEYS.include? key
      end

      self.instance_eval(&block) if block_given?
    end

    # Get Data from an Email
    def get_data(email)
      get_request '/initial_data', :email => email
    end

  end # Client
end
