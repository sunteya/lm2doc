require "lm2doc"
require 'optparse'
require "pry"


theme_name = "bootstrap"
options = { }

opts = OptionParser.new do |opts|
  opts.banner = "lm2doc is a converter for lightweight markup language to pretty html document."
  opts.separator ""
  opts.separator "Usage:"
  opts.separator "    lm2doc [OPTION]... DIR|FILE"
  opts.separator ""
  
  opts.separator "Options:"
  opts.on("-v", "--version", "show the version of lm2doc") { puts Lm2doc::VERSION; exit }
  # opts.on("-t", "--theme NAME", "output html theme: bootstap (default)") {|v| options[:theme] = v }
  opts.on("-o", "--out DIR", "output result dir") {|v| options[:out] = v }
end
opts.parse!

if ARGV.length != 1
  puts opts.help()
  exit
end

file_or_dir = ARGV[0]

theme = Lm2doc.theme(theme_name)
theme.generate(file_or_dir, options)


