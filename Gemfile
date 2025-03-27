source "https://rubygems.org"

ruby "3.3.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.5", ">= 7.1.5.1"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# devise
gem 'devise'
gem 'devise_invitable'
gem 'devise-jwt'

# [https://rubygems.org/gems/active_model_serializers]
gem 'active_model_serializers', '~> 0.10.2'

# Redis
gem "redis"

gem 'kaminari'

# Sidekiq
gem "sidekiq"
gem "sidekiq-scheduler"

gem 'dotenv'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "pry-rails"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

