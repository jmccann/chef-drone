source 'https://rubygems.org'

if RUBY_VERSION =~ /^1.9/
  gem 'ohai', "~> 7.4"
  gem 'chef', "> 11.0.0", "< 12.0.0"
end

gem 'berkshelf'
gem 'emeril'
gem 'foodcritic'
gem 'rake'
gem 'rubocop'
gem 'chefspec'
gem 'docker-api'

group :integration do
  gem 'kitchen-vagrant'
  gem 'serverspec'
  gem 'specinfra'
  gem 'test-kitchen'
end
