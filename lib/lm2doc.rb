require "pathname"

module Lm2doc
  VERSION = "0.0.1"
  
  def self.root
    Pathname.new(File.expand_path("../../", __FILE__))
  end
  
  
  def method_name
    
  end
end

require_relative 'lm2doc/markdown'
require_relative 'lm2doc/theme'
