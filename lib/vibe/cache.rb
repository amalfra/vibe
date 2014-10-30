module Vibe
  class Cache

    extend Configuration
    include Error

    DRIVERS = ['FILE']

    def initialize(options = {})
      # If invalid cache driver given
      if options.include?(:driver) && !DRIVERS.include?(options[:driver])
        raise ArgumentError, "unkown cache driver: #{options[:driver]}"
      else
        # Load the required cache driver
        require "vibe/cache-drivers/#{options[:driver].downcase}"
        @driver = eval(options[:driver].downcase.capitalize).new
      end
    end

    # Get key from cache, proxies into
    # method with same name in driver class
    #
    # @return [Driver.get]
    def get(key = '')
      @driver.get(key)
    end

    # Write to cache, proxies into
    # method with same name in driver class
    #
    # @return [Driver.put]
    def put(key = '', data = '')
      @driver.put(key, data)
    end

  end # Cache
end
