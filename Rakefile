require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

RSpec::Core::RakeTask.new
desc "Run specs"
task :default => :spec
