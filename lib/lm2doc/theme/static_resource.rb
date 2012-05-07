require "fileutils"

module Lm2doc
  class Theme
    class StaticResource
      
      attr_accessor :base, :relative_path
      
      def initialize(base, relative_path)
        self.base = base
        self.relative_path = relative_path
      end
      
      def file_out(dir, options = {})
        source = File.join(self.base, self.relative_path)
        target = File.join(dir, self.relative_path)
        
        return if File.absolute_path(source) == File.absolute_path(target)
        
        FileUtils.mkdir_p File.dirname(target)
        FileUtils.rm_rf target
        FileUtils.cp_r source, target
      end
      
      def print_out
      end
      
    end
  end
end