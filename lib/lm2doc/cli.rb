require "lm2doc"
require 'optparse'
require "pry"

# binding.pry
options = {
  :theme => "bootstrap"
}

opts = OptionParser.new do |opts|
  opts.banner = "lm2doc is a converter for lightweight markup language to pretty html document."
  opts.separator ""
  opts.separator "Usage:"
  opts.separator "    lm2doc [OPTION]... DIR|FILE"
  opts.separator ""
  
  opts.separator "Options:"
  opts.on("-t", "--theme NAME", "output html theme: bootstap (default)") {|v| options[:theme] = v }
  opts.on("-v", "--version", "show the version of lm2doc") { puts Lm2doc::VERSION; exit }
  opts.on("-o", "--out DIR", "output result dir") {|v| options[:out] = v }
end
opts.parse!

if ARGV.length != 1
  puts opts.help()
  exit
end

raise OptionParser::MissingArgument if options[:out].nil?


path = ARGV[0]

source = Lm2doc::Source.build(path)
source.render!(options)

# text = File.read(file)

# result = Lm2doc::Converter.new(path).convert!
# html = .render(result)
# puts html

