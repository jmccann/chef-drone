require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.formatter = :documentation
  config.color = true
end

at_exit { ChefSpec::Coverage.report! }
