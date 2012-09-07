require "pathname"
require "fileutils"
require "active_support/all"

module Lm2doc
  VERSION = "0.0.1"
  
  def self.root
    Pathname.new(File.expand_path("../../", __FILE__))
  end
  
  
  def self.tmpdir
    Lm2doc.root.join("tmp")
  end
  
  def self.mktmpdir
    FileUtils.mkdir_p(tmpdir)
    Dir.mktmpdir(nil, tmpdir) do |tmpdir|
      yield(tmpdir)
    end
  end
end

require_relative 'lm2doc/markdown'
require_relative 'lm2doc/resource/source'
require_relative 'lm2doc/theme'
