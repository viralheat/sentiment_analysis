# encoding: UTF-8
require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake'

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end
task :default => :spec

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs    << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov    = true
end

require 'rdoc/task'
RDoc::Task.new do |rdoc|
end
