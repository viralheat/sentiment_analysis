require 'rubygems'
require 'sentiment_analysis'

require 'spec'

Spec::Runner.configure do |config|
  config.before(:each) do
  end
end

SPECS_DIR = File.expand_path(File.dirname(__FILE__))

Dir[File.join(SPECS_DIR, 'support/**/*.rb')].each {|f| require f}

OPTIONS = YAML::load(File.open(File.join(SPECS_DIR, 'config.yml')))
API_KEY = OPTIONS['api_key']
