# -*- coding: utf-8 -*-
require File.expand_path('../lib/simple_track/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["grasp"]
  gem.email         = ["hunter.wxhu@gmail.com"]
  gem.description   = %q{Write a gem description}
  gem.summary       = %q{Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "simple_track"
  gem.require_paths = ["lib", "app"]
  gem.version       = SimpleTrack::VERSION

  gem.add_dependency "padrino-core"
end
