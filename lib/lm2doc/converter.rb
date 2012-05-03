

module Lm2doc
  class Converter
    attr_accessor :file, :base, :title, :include_siblings
    
    def initialize(path)
      self.file = path
      self.file = File.join(path, "index.md") if File.directory?(path)
      
      if File.basename(self.file) == "index.md"
        self.include_siblings = true
        self.base = File.dirname(self.file)
        self.title = File.basename(self.base)
      else
        self.base = File.dirname(self.file)
        self.title = File.basename(self.file, File.extname(self.file))
      end
    end
    
    def convert!
      body = Kramdown::Document.new(File.read(file)).to_html
      
      if include_siblings
        dir = Pathname.new(base)
        result[:resources] = dir.children.map{|c| c.relative_path_from(dir) }
      end
      
      result
    end
  end
end