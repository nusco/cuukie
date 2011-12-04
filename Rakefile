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
