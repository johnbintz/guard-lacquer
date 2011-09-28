# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "guard-lacquer"
  s.version     = '0.0.1'
  s.authors     = ["John Bintz"]
  s.email       = ["john@coswellproductions.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "guard-lacquer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'lacquer'
  s.add_runtime_dependency 'guard'

  s.add_development_dependency 'rspec', '~> 2.6.0'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'guard-rspec'
end
