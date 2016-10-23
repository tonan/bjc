require 'chefspec'
require 'chefspec/berkshelf'

# Configuration
RSpec.configure do |config|
  config.log_level = :fatal
  config.platform = 'windows'
  config.version = '2012R2'
end
