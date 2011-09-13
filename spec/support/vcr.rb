require 'vcr'
require 'fakeweb'


VCR_CASSETTES_DIR = File.join(SPECS_DIR, 'vcr_cassette_library')

VCR.config do |c|
  c.cassette_library_dir     = VCR_CASSETTES_DIR
  c.stub_with                :fakeweb
  c.ignore_localhost         = true
  c.default_cassette_options = { :record => :none }
# c.allow_http_connections_when_no_cassette = true
end


Spec::Runner.configure do |c|
  c.extend VCR::RSpec::Macros
end
