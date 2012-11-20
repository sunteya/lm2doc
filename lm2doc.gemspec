# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["sunteya"]
  gem.email         = ["sunteya@gmail.com"]
  gem.description   = %q{generate pretty html document by lightweight markup language}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/sunteya/lm2doc"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "lm2doc"
  gem.require_paths = ["lib"]
  gem.version       = File.read(File.expand_path("../VERSION", __FILE__)).chomp
  
  
  gem.add_dependency "activesupport"
  gem.add_dependency "hashie"
  gem.add_dependency "nokogiri"
  
  gem.add_dependency "kramdown", "~> 0.14.0"
  gem.add_dependency "pygments.rb", "~> 0.2.13"
  
  gem.add_dependency "compass"
  gem.add_dependency "bootstrap-sass", "~> 2.1.0.0"
  
  
  # Test & Development
  gem.add_development_dependency "rake"
  gem.add_development_dependency "pry-nav"
  gem.add_development_dependency "version"
  
  gem.add_development_dependency "rspec"
end
