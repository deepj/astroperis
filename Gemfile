# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 7.0.4"
gem "bootsnap", require: false

gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "propshaft"

gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "devise"
gem "omniauth-github"
gem "omniauth-gitlab"
gem "omniauth-rails_csrf_protection"

gem "shrine"
gem "aws-sdk-s3"
gem "sidekiq"
gem "pagy"
gem "down"

group :development, :test do
  gem "ruby-progressbar"
  gem "faker"
  gem "standard"
  gem "debug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
