# frozen_string_literal: true

require_relative 'lib/lsuuid/version'

Gem::Specification.new do |spec|
  spec.name          = 'lsuuid'
  spec.version       = LSUUID::VERSION
  spec.authors       = ['Hypto Engineering Team']
  spec.email         = ['engineering@hypto.in']

  spec.summary       = 'Universally Unique Lexicographically Sortable Identifier'
  spec.description   = 'Universally Unique Lexicographically Sortable Identifier'
  spec.homepage      = 'https://github.com/hwslabs/lsuuid'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.4.0'

  # spec.metadata['allowed_push_host'] = 'TODO: Set to 'https://mygemserver.com''

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/hwslabs/lsuuid'
  spec.metadata['changelog_uri'] = 'https://github.com/hwslabs/lsuuid/blob/main/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
