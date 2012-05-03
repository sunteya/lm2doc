require "fileutils"

module Lm2doc
  class Resource
    
    attr_accessor :base, :file
    
    def initialize(base, file)
      self.base = base
      self.file = file
    end
    
    def output(dir, options = {})
      source = File.join(self.base, self.file)
      target = File.join(dir, self.file)
      
      return if File.absolute_path(source) == File.absolute_path(target)
      
      FileUtils.mkdir_p File.dirname(target)
      FileUtils.rm_rf target
      FileUtils.cp_r source, target
    end
    
  end
end