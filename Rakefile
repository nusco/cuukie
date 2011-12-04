# FIXME: why does this fail after loading Bundler?
require 'rspec/core/rake_task'

require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

task :default => :spec

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec)

desc "Run Cuukie (assumes that there is a cuukie_server on the local machine and the default port)"
task :smoke_test do
  system "cucumber spec/test_project/features --require spec/test_project/features/step_definitions/ --require lib/cuukie/formatter --format Cuukie --guess"
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "cuukie"
  gem.homepage = "http://github.com/nusco/cuukie"
  gem.license = "MIT"
  gem.summary = %Q{A continuous view on Cucumber features}
  gem.description = %Q{Cuukie shows the result of running Cucumber feature on a remote server.}
  gem.email = "paolo.nusco.perrotta@gmail.com"
  gem.authors = ['Paolo "Nusco" Perrotta']
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "cuukie #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
