module D2S3
  class S3Config
    require 'yaml'

    cattr_reader :access_key_id, :secret_access_key, :bucket

    def self.load_config
      filename = "#{RAILS_ROOT}/config/amazon_s3.yml"
      file = File.open(filename)
      config = YAML.load(file)

      @@access_key_id     = config[RAILS_ENV]['access_key_id']
      @@secret_access_key = config[RAILS_ENV]['secret_access_key']
      @@bucket            = config[RAILS_ENV]['bucket_name']
      
      unless @@access_key_id && @@secret_access_key
        raise "Please configure your S3 settings in #{filename}."
      end
    end
  end
end
