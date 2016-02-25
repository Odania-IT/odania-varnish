require 'odania'
require 'rspec'

BASE_DIR = File.dirname(__FILE__) unless defined? 'BASE_DIR'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

# Import custom tasks to keep the main Rakefile small
Dir.glob('tasks/*.rake').each { |r| import r }

task :default => ['spec']

