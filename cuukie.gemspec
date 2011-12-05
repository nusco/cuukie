# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "cuukie"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paolo \"Nusco\" Perrotta"]
  s.date = "2011-12-05"
  s.description = "Shows Cucumber results on a web page as they run."
  s.email = "paolo.nusco.perrotta@gmail.com"
  s.executables = ["cuukie_server"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    ".autotest",
    ".rspec",
    ".travis.yml",
    "Gemfile",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "bin/cuukie_server",
    "cuukie.gemspec",
    "doc/LICENSE.txt",
    "doc/backlog.txt",
    "doc/pomodoro.txt",
    "lib/cuukie.rb",
    "lib/cuukie/cucumber/formatter/cuukie.rb",
    "lib/cuukie/public/cucumber.css",
    "lib/cuukie/public/cuukie.js",
    "lib/cuukie/public/jquery-1.7.min.js",
    "lib/cuukie/server.rb",
    "lib/cuukie/views/index.erb",
    "lib/test.rb",
    "spec/commands_spec.rb",
    "spec/cuukie_spec.rb",
    "spec/test_project/features/1_visualize_scenarios.feature",
    "spec/test_project/features/2_multiple_features.feature",
    "spec/test_project/features/3_failed_background.feature",
    "spec/test_project/features/step_definitions/example_steps.rb",
    "spec/test_project/features/support/formatters.rb"
  ]
  s.homepage = "http://github.com/nusco/cuukie"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "A continuous view on Cucumber features"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 0"])
      s.add_runtime_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

