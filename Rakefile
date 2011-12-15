require 'bundler/setup'

task :default => 'test:specs'

namespace :test do
  require 'rspec/core/rake_task'
  desc "Run all specs"
  RSpec::Core::RakeTask.new(:specs)

  desc "Run Cuukie on the test project (needs a cuukie server on localhost, default port)"
  task :manual do
    system "cd spec/test_project && \
            cucumber --format cuukie"
  end
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "cuukie"
  gem.homepage = "http://github.com/nusco/cuukie"
  gem.license = "MIT"
  gem.summary = %Q{A continuous view on Cucumber features}
  gem.description = %Q{Shows Cucumber results on a web page as they run.}
  gem.email = "paolo.nusco.perrotta@gmail.com"
  gem.authors = ['Paolo "Nusco" Perrotta']
end
Jeweler::RubygemsDotOrgTasks.new
