source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
#gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "tzinfo-data"
gem "tzinfo"
gem "bootsnap", require: false
gem 'devise', '~> 4.8', '>= 4.8.1'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.7', '>= 3.7.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
