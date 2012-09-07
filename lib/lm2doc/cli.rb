require 'optparse'
require_relative "../lm2doc"

module Lm2doc
  class Cli
    attr_accessor :argv, :inputs, :output
    
    def initialize(argv)
      self.argv = argv
    end
    
    def theme
      Lm2doc.theme("bootstrap")
    end
    
    def parse_argv
      self.inputs = []
      
      opts = OptionParser.new(self.argv.dup) do |opts|
        opts.banner = "lm2doc is a convertor for lightweight markup language to pretty html document."
        opts.separator ""
        opts.separator "Usage:"
        opts.separator "    lm2doc [OPTION]...[-i] FILE"
        opts.separator ""
        
        opts.separator "Options:"
        opts.on("-v", "--version", "show the version of lm2doc") { puts Lm2doc::VERSION; exit }
        opts.on("-i", "--in FILE", "input path") {|v| self.inputs = [ v ] }
        # opts.on("-o", "--out DIR|FILE", "output path") {|v| self.output = v }
      end
      
      others = opts.parse!
      self.inputs = others
      
      if self.inputs.length != 1
        puts opts.help()
        exit
      end
    end
    
    def execute
      self.parse_argv
      
      self.inputs.each do |input|
        perfrom_source(input)
      end
    end
    
    def perfrom_source(source_file)
      source = Resource::Source.build(source_file)
      
      output_dir = File.dirname(source_file)
      FileUtils.mkdir_p(output_dir)
      source.write(output_dir, :theme => theme)
    end
    
  end
end