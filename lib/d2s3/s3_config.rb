module D2S3
  class S3Config
    require 'yaml'
    require "#{Rails.root}/config/environment.rb"

    cattr_reader :access_key_id, :secret_access_key, :bucket

    def self.load_config
      filename = "#{Rails.root}/config/amazon_s3.yml"
      config = YAML.load_file(filename)

      unless config
        raise "Config object from #{filename} is nil"
      end

      unless config[Rails.env]
        raise "No environment #{Rails.env} found in #{filename}"
      end

      @@access_key_id     = config[Rails.env]['access_key_id']
      @@secret_access_key = config[Rails.env]['secret_access_key']
      @@bucket            = config[Rails.env]['bucket_name']
      
      unless @@access_key_id && @@secret_access_key && @@bucket
        raise "Please configure your S3 settings in #{filename}."
      end
    end
  end
end
