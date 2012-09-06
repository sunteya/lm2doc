# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["sunteya"]
  gem.email         = ["sunteya@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "https://github.com/sunteya/lm2doc"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "lm2doc"
  gem.require_paths = ["lib"]
  gem.version       = File.read(File.expand_path("../VERSION", __FILE__)).chomp
  
  
  gem.add_dependency "bundler"
  
  gem.add_dependency "active_attr"
  gem.add_dependency "hashie"
  gem.add_dependency "nokogiri"
  
  gem.add_dependency "kramdown"
  gem.add_dependency "coderay"
  
  gem.add_dependency "compass"
  gem.add_dependency "bootstrap-sass"
  
  
  # Test & Development
  gem.add_development_dependency "rake"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "version"
  
  gem.add_development_dependency "rspec"
end
