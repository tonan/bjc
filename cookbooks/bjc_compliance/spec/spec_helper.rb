require 'chefspec'
require 'chefspec/berkshelf'

# Configuration
RSpec.configure do |config|
  config.log_level = :fatal
  config.platform = 'ubuntu'
  config.version = '14.04'
end
