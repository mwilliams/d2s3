module D2S3
  if defined?(Rails::Railtie)
    class S3Config < Rails::Railtie
      require 'yaml'

      cattr_reader :access_key_id, :secret_access_key, :bucket

      initializer :load_s3_config, :after => :load_environment_config, :group => :all do
        require File.join(Rails.root, "config", "environment.rb")
      end

      def self.load_config
        filename = Rails.root.join("config", "amazon_s3.yml").to_s
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
end
