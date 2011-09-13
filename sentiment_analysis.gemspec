# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sentiment_analysis/version"

Gem::Specification.new do |s|
  s.name        = "sentiment_analysis"
  s.version     = SentimentAnalysis::VERSION
  s.authors     = ["Alain Ravet"]
  s.email       = ["alain.ravet@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Client for the SentimentAnalysis API}
  s.description = %q{Client for the SentimentAnalysis API}

  s.rubyforge_project = "sentiment_analysis"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "httparty"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rdoc"
  s.add_development_dependency "vcr"
  s.add_development_dependency "fakeweb"
end
