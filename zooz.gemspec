Gem::Specification.new do |s|
  s.name        = 'zooz'
  s.version     = '1.0.2'
  s.date        = '2012-08-23'
  s.summary     = "ZooZ"
  s.description = "A ZooZ API library for Ruby"
  s.authors     = ["Michael Alexander"]
  s.email       = 'beefsack@gmail.com'
  s.files       = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
  s.homepage    = 'https://github.com/Miniand/zooz-ruby'
  s.add_dependency('activesupport', '~> 3.2.0')
  s.add_dependency('httparty', '~> 0.8.0')
end
