# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "magic_user/version"

Gem::Specification.new do |s|
  s.name        = "magic_user"
  s.version     = MagicUser::VERSION
  s.authors     = ["Michael Balsiger"]
  s.email       = ["michael.balsiger@swisscom.com"]
  s.homepage    = ""
  s.summary     = %q{ActiveRecord extension}
  s.description = %q{Active Record automatically userstamps create and update operations if the table has fields named created_by or updated_by.}
  
  s.required_ruby_version = '>= 1.8.7'

  s.rubyforge_project = "magic_user"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
