require 'optparse'
require_relative "../lm2doc"

module Lm2doc
  class Cli
    attr_accessor :argv, :options
    
    def initialize(argv)
      self.argv = argv
    end
    
    def theme
      Lm2doc.theme("bootstrap")
    end
    
    def parse
      self.options = {
        inputs: []
      }
      
      opts = OptionParser.new(self.argv.dup) do |opts|
        opts.banner = "lm2doc is a converter for lightweight markup language to pretty html document."
        opts.separator ""
        opts.separator "Usage:"
        opts.separator "    lm2doc [OPTION]...[-i] DIR|FILE"
        opts.separator ""
        
        opts.separator "Options:"
        opts.on("-v", "--version", "show the version of lm2doc") { puts Lm2doc::VERSION; exit }
        opts.on("-i", "--in DIR|FILE", "input path") {|v| options[:inputs] = [ v ] }
        opts.on("-o", "--out DIR|FILE", "output path") {|v| options[:output] = v }
      end
      
      others = opts.parse!
      options[:inputs] = others
      
      if options[:inputs].length != 1
        puts opts.help()
        exit
      end
    end
    
    def execute
      self.parse
      
      self.options[:inputs].each do |input|
        theme.generate(input, options)
      end
    end
  end
end