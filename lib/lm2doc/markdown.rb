require "kramdown"

module Lm2doc
  
  class Markdown < Resource
    
    def initialize(*args)
      super
    end
    
    def output(dir, options)
      theme = options[:theme]
      resources = self.process(theme)
      
      resources.each do |resource|
        resource.output(dir, options)
      end
    end
    
    def process(theme)
      source = File.join(self.base, self.file)
      text = File.read(source)
      body = Kramdown::Document.new(text).to_html
      result = {
        :base => self.base,
        :file => self.file,
        :article => body
      }
      theme.render(result)
    end
    
  end
end