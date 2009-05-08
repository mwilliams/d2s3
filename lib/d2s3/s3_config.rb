module D2S3
  class S3Config
    require 'yaml'

    cattr_reader :access_key_id, :secret_access_key, :bucket

    def self.load_config
      filename = "#{RAILS_ROOT}/config/amazon_s3.yml"
      config = YAML.load_file(filename)
      
      unless config
        raise "Config object from #{filename} is nil"
      end
      
      unless config[RAILS_ENV]
        raise "No environment #{RAILS_ENV} found in #{filename}"
      end

      @@access_key_id     = config[RAILS_ENV]['access_key_id']
      @@secret_access_key = config[RAILS_ENV]['secret_access_key']
      @@bucket            = config[RAILS_ENV]['bucket_name']
      
      unless @@access_key_id && @@secret_access_key && @@bucket
        raise "Please configure your S3 settings in #{filename}."
      end
    end
  end
end
