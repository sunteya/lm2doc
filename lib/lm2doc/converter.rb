module Lm2doc
  class Converter
    include ActiveSupport::Callbacks
    
    attr_accessor :content
    define_callbacks :convert
    
    def as_html
      run_callbacks :convert do
        convert
      end
    end
    
    def self.perfer_exts
      []
    end
    
  end
end