# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "cuukie"
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paolo \"Nusco\" Perrotta"]
  s.date = "2011-12-16"
  s.description = "A drop-in replacement for the \"cucumber\" command. It shows running features on a web page."
  s.email = "paolo.nusco.perrotta@gmail.com"
  s.executables = ["cuukie"]
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
    "bin/cuukie",
    "cuukie.gemspec",
    "doc/LICENSE.txt",
    "doc/backlog.txt",
    "doc/pomodoro.txt",
    "lib/cuukie.rb",
    "lib/cuukie/cli.rb",
    "lib/cuukie/client.rb",
    "lib/cuukie/code_snippets.rb",
    "lib/cuukie/formatter.rb",
    "lib/cuukie/server/public/cucumber.css",
    "lib/cuukie/server/public/cuukie.js",
    "lib/cuukie/server/public/jquery-1.7.min.js",
    "lib/cuukie/server/server.rb",
    "lib/cuukie/server/views/index.erb",
    "spec/cli_spec.rb",
    "spec/code_snippets_spec.rb",
    "spec/commands_spec.rb",
    "spec/cuukie_spec.rb",
    "spec/spec_helper.rb",
    "spec/test_project/features/1_show_scenarios.feature",
    "spec/test_project/features/2_show_multiline_args.feature",
    "spec/test_project/features/3_failed_background.feature",
    "spec/test_project/features/4_exception_with_no_source.feature",
    "spec/test_project/features/step_definitions/exception_steps.rb",
    "spec/test_project/features/step_definitions/main_steps.rb"
  ]
  s.homepage = "http://github.com/nusco/cuukie"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "A continuous view on Cucumber features"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, ["~> 1.3"])
      s.add_runtime_dependency(%q<cucumber>, ["~> 1.1"])
      s.add_runtime_dependency(%q<rest-client>, ["~> 1.6"])
      s.add_runtime_dependency(%q<launchy>, [">= 0"])
      s.add_runtime_dependency(%q<syntax>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, ["~> 1.3"])
      s.add_dependency(%q<cucumber>, ["~> 1.1"])
      s.add_dependency(%q<rest-client>, ["~> 1.6"])
      s.add_dependency(%q<launchy>, [">= 0"])
      s.add_dependency(%q<syntax>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, ["~> 1.3"])
    s.add_dependency(%q<cucumber>, ["~> 1.1"])
    s.add_dependency(%q<rest-client>, ["~> 1.6"])
    s.add_dependency(%q<launchy>, [">= 0"])
    s.add_dependency(%q<syntax>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

