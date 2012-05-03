require "pathname"

module Lm2doc
  VERSION = "0.0.1"
  
  def self.root
    Pathname.new(File.expand_path("../../", __FILE__))
  end
  
  autoload :Source,    'lm2doc/source'
  autoload :Resource,  'lm2doc/resource'
  autoload :Markdown,  'lm2doc/markdown'
  autoload :Theme,     'lm2doc/theme'
  autoload :ContentResource, 'lm2doc/content_resource'
end
