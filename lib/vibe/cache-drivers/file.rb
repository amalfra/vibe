module Vibe
  class File

    def initialize(cache_dir = '')
      @cache_dir = '/tmp/vibe_gem/' if cache_dir == ''

      if !Dir.exists?(@cache_dir)
          Dir.mkdir(@cache_dir)
      end
    end

    def get(key = '')
      if key != '' && ::File.exists?(@cache_dir+key)
        puts "Reading from cache with key: #{key}" if ENV['DEBUG']
        data = ::File.read(@cache_dir+key)
        return (data.length > 0) ? data : false
      end

      return false
    end

    def put(key = '', data = '')
      if key != '' && data != ''
        puts "Writing into cache with key: #{key}" if ENV['DEBUG']
        return ::File.write(@cache_dir+key, data)
      end

      return false
    end

  end # File
end
