require 'rubygems'
require 'sentiment_analysis'

require 'spec'

Spec::Runner.configure do |config|
  config.before(:each) do
  end
end

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each {|f| require f}

OPTIONS = YAML::load(File.open(File.join(File.dirname(__FILE__), 'config.yml')))
API_KEY = OPTIONS['api_key']
