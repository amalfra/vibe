module Vibe
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :user_agent, :method, :format].freeze
    VALID_OPTIONS_KEYS    = [:api_key, :cache, :cache_driver].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT      = 'https://vibeapp.co/api/v1/'.freeze
    DEFAULT_METHOD        = :get.freeze
    DEFAULT_USER_AGENT    = "Vibe API Ruby Gem #{Vibe::VERSION}".freeze

    DEFAULT_API_KEY       = nil
    DEFAULT_FORMAT        = :json.freeze

    DEFAULT_CACHE_DRIVER  = 'FILE'.freeze
    DEFAULT_CACHE         = true

    # Build accessor methods for every config options so we can do this
    attr_accessor *Configuration::VALID_CONFIG_KEYS

    @endpoint     = DEFAULT_ENDPOINT
    @method       = DEFAULT_METHOD
    @user_agent   = DEFAULT_USER_AGENT
    @format       = DEFAULT_FORMAT
    @cache_driver = DEFAULT_CACHE_DRIVER
    @cache        = DEFAULT_CACHE

    # Make sure we have the default values set when we get 'extended'
    def self.extended(base)
      base.reset
    end

    # Setup Configuration
    def configure
      yield self
    end

    def reset
      self.endpoint     = DEFAULT_ENDPOINT
      self.method       = DEFAULT_METHOD
      self.user_agent   = DEFAULT_USER_AGENT
      self.format       = DEFAULT_FORMAT

      self.api_key      = DEFAULT_API_KEY
      self.cache_driver = DEFAULT_CACHE_DRIVER
      self.cache        = true
    end

    # Return the configuration values set in this module
    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end

  end # Configuration
end
