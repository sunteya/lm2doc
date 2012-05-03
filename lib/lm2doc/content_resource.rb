module Lm2doc
  class ContentResource
    
    attr_accessor :file, :content
    
    def initialize(file, content)
      self.file = file
      self.content = content
    end
    
    def output(dir, options = {})
      target = File.join(dir, self.file)
      FileUtils.mkdir_p File.dirname(target)
      File.open(target, "w") do |f|
        f << self.content
      end
    end
  end
end