require_relative '../resource'

module Lm2doc
  class Resource
    class Source < Resource
      
      attr_accessor :content, :basename
      
      def initialize(file, converter)
        self.file = file
        extname = File.extname(file)
        self.basename = File.basename(file, extname)
        
        raw = File.read(self.file)
        converter.content = raw
        self.content = converter.as_html
      end
        
      def write(dir, options = {})
        theme = options[:theme]
        result = theme.render(:article => self.content)
        
        target = File.join(dir, "#{basename}.html")
        File.open(target, "w") { |f| f << result }
        
        theme.write_assets(dir)
      end
      
      def self.build(file)
        extname = File.extname(file)
        converter_class = Converter.subclasses.find {|clazz| clazz.perfer_exts.include?(extname) }
        converter = converter_class.new
        
        self.new(file, converter)
      end
    end
  end
end