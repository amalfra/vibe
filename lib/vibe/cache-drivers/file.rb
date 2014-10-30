module Vibe
  class File

    def initialize(cache_dir = '')
      @cache_dir = Dir.tmpdir()+'/vibe_gem/' if cache_dir == ''

      if !Dir.exists?(@cache_dir)
          Dir.mkdir(@cache_dir)
      end
    end

    def get(key = '')
      if key != '' && ::File.exists?(@cache_dir+key)
        # Is the File older than a day?
        if file_age(@cache_dir+key) > 1
          # Delete and return a cache miss
          File.delete(@cache_dir+key)
          return false
        end

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

    def file_age(name)
      (Time.now - ::File.stat(name).mtime)/(24*3600)
    end

  end # File
end
