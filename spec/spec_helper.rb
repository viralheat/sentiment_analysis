require 'rubygems'
require 'sentiment_analysis'

require 'spec'

Spec::Runner.configure do |config|
  config.before(:each) do
  end
end

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each {|f| require f}

