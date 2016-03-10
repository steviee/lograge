require './lib/lograge/version'

Gem::Specification.new do |s|
  s.name        = 'lograge'
  s.version     = Lograge::VERSION
  s.authors     = ['Mathias Meyer', 'Ben Lovell', 'Stephan Eberle']
  s.email       = ['meyer@paperplanes.de', 'benjamin.lovell@gmail.com', 'steviee77@gmail.com']
  s.homepage    = 'https://github.com/steviee/lograge'
  s.summary     = "Tame Rails' multi-line logging into a single line per request"
  s.description = "Tame Rails' multi-line logging into a single line per request"
  s.license     = 'MIT'

  s.files = `git ls-files lib`.split("\n")

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop', '0.37.2'

  s.add_runtime_dependency 'activesupport', '>= 4', '<= 5.0.0.beta3'
  s.add_runtime_dependency 'activerecord', '>= 4', '<= 5.0.0.beta3'
  s.add_runtime_dependency 'actionpack', '>= 4', '<= 5.0.0.beta3'
  s.add_runtime_dependency 'railties', '>= 4', '<= 5.0.0.beta3'
end
