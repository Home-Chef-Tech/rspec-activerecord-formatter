# encoding: utf-8

lib_dir = File.join(File.dirname(__FILE__),'lib')
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

Gem::Specification.new do |gem|

  gem.name    = "rspec-activerecord-formatter"
  gem.version = "2.2.2"

  gem.summary     = "Adds object creations and queries to Rspec output."
  gem.description = "Creates a new formatter for ActiveRecord that can help you diagnose performance issues in RSpec"
  gem.licenses    = "MIT"
  gem.authors     = "Joseph Mastey"
  gem.email       = "jmmastey@gmail.com"
  gem.homepage    = "http://github.com/jmmastey/rspec-activerecord-formatter"

  glob = lambda { |patterns| gem.files & Dir[*patterns] }

  gem.files       = `git ls-files`.split($/)

  gem.extensions       = glob['ext/**/extconf.rb']
  gem.test_files       = glob['{spec/{**/}*_spec.rb']
  gem.extra_rdoc_files = glob['*.{txt,md}']

  gem.require_paths = %w[ext lib].select { |dir| File.directory?(dir) }

  gem.add_dependency "activesupport", ">= 4.0", "< 8.0"
  gem.add_dependency "rspec", ">= 3.4"

  gem.add_development_dependency "coveralls", "~> 0.8"
end
