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
  gem.description = %Q{A drop-in replacement for the "cucumber" command. It shows running features on a web page.}
  gem.summary = %Q{A continuous view on Cucumber features}
  gem.email = "paolo.nusco.perrotta@gmail.com"
  gem.authors = ['Paolo "Nusco" Perrotta']
end
Jeweler::RubygemsDotOrgTasks.new
