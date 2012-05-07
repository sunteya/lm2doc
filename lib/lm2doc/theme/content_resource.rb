module Lm2doc
  class Theme
    class ContentResource
      attr_accessor :relative_path, :content
      
      def initialize(relative_path, content)
        self.relative_path = relative_path
        self.content = content
      end
      
      def file_out(dir, options = {})
        target = File.join(dir, self.relative_path)
        FileUtils.mkdir_p File.dirname(target)
        File.open(target, "w") do |f|
          f << self.content
        end
      end
      
      def print_out
        self.content
      end
      
    end
  end
end