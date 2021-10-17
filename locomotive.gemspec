# frozen_string_literal: true

require_relative 'lib/locomotive/version'

Gem::Specification.new do |spec|
  spec.name          = 'locomotive'
  spec.version       = Locomotive::VERSION
  spec.authors       = ['mkiroshdz']
  spec.email         = ['nika.kirosh@gmail.com']

  spec.summary       = 'A web based ruby framework'
  spec.description   = 'A web based ruby framework'
  spec.homepage      = 'https://github.com/mkiroshdz/locomotive'
  spec.required_ruby_version = '>= 2.4.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mkiroshdz/locomotive'
  spec.metadata['changelog_uri'] = 'https://github.com/mkiroshdz/locomotive'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rack'
  spec.add_runtime_dependency 'zeitwerk'
  spec.add_development_dependency 'rack-test'
end
