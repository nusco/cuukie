require 'bundler/setup'

task :default => 'test:specs'

namespace :test do
  require 'rspec/core/rake_task'
  desc "Run all specs"
  RSpec::Core::RakeTask.new(:specs)

  desc "Run Cuukie on the test project (needs a cuukie_server on localhost, default port)"
  task :smoke do
    system "cucumber spec/test_project/features \
            --require spec/test_project/features/step_definitions/ \
            --require lib/cuukie/formatter \
            --format Cuukie \
            --guess"
  end
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "cuukie"
  gem.homepage = "http://github.com/nusco/cuukie"
  gem.license = "MIT"
  gem.summary = %Q{A continuous view on Cucumber features}
  gem.description = %Q{Cuukie shows the result of running Cucumber feature on a remote server.}
  gem.email = "paolo.nusco.perrotta@gmail.com"
  gem.authors = ['Paolo "Nusco" Perrotta']
end
Jeweler::RubygemsDotOrgTasks.new
