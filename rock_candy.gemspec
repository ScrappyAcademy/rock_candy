# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rock_candy/version'

Gem::Specification.new do |spec|
  spec.name          = 'rock_candy'
  spec.version       = RockCandy::VERSION
  spec.authors       = ['Scrappy Academy']
  spec.description   = %q{Provides sugary syntax to help crystalize your test/spec structure.}
  spec.summary       = %q{Ruby test sugar add-on.}
  spec.homepage      = 'https://github.com/ScrappyAcademy/rock_candy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14'
  spec.add_development_dependency "coveralls"
end
