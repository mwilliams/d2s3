# -*- encoding: utf-8 -*-
require File.expand_path('../lib/d2s3/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Matthew Williams"]
  gem.email         = [""]
  gem.description   = %q{d2s3 (direct to s3) is a simple Ruby on Rails helper that generates an upload form that will take a given file and upload it directly to your S3 bucket, bypassing your server}
  gem.summary       = %q{Ruby on Rails helper to generate S3 upload form}
  gem.homepage      = "https://github.com/mwilliams/d2s3"
  gem.license       = ""

  gem.files         = ["README.markdown", "Rakefile", "init.rb", "lib/d2s3.rb", "lib/d2s3/s3_config.rb", "lib/d2s3/view_helpers.rb", "tasks/d2s3_tasks.rake", "test/d2s3_test.rb", "test/test_helper.rb"]
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.name          = "d2s3"
  gem.require_paths = ["lib"]
  gem.version       = D2S3::VERSION

  gem.add_development_dependency 'rake'
end
