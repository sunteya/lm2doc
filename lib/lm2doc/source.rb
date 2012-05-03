module Lm2doc
  
  class Source
    attr_accessor :base, :file
    
    def initialize(attrs)
      attrs.each_pair do |name, value|
        send "#{name}=", value
      end
    end
    
    def resources
      result = []
      if self.file
        result << Markdown.new(self.base, self.filename)
      else
        dir = Pathname.new(self.base)
        
        dir.children.each do |child|
          file = child.relative_path_from(dir).to_s
          extname = File.extname(file)
          
          if extname == ".md"
            result << Markdown.new(self.base, file)
          else
            result << Resource.new(self.base, file)
          end
        end
      end
      
      result
    end
    
    def render!(options)
      out = options[:out]
      theme = Theme.new(options[:theme])
      
      resources.each do |resource|
        resource.output(out, { :theme => theme })
      end
    end
    
    def self.build(path)
      if File.directory?(path)
        Source.new(:base => path)
      else
        Source.new(:base => File.dirname(path), :file => File.basename(path))
      end
    end
  end
end