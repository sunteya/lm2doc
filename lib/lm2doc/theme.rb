require 'erb'

module Lm2doc
  
  class Theme
    
    attr_accessor :name
    
    def initialize(name)
      self.name = name
    end
    
    def render(result)
      erb_file = filepath("template.html.erb")
      template = ERB.new(File.read(erb_file))
      
      @body = result[:article]
      @title = result[:title]
      content = template.result(binding)
      
      file = result[:file]
      extname = File.extname(file)
      basename = File.basename(file, extname)
      
      resources = [] + self.static_resources
      resources << ContentResource.new("#{basename}.html", content)
    end
    
    def filepath(file)
      Theme.base_dir.join(self.name, file)
    end
    
    def static_resources
      css = filepath("style.css")
      [
        ContentResource.new("style.css", File.read(css))
      ]
    end
    
    
    def self.base_dir
      Lm2doc.root.join("themes")
    end
    
  end
end