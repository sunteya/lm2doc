require "hashie"
require "tempfile"
require "fileutils"

module Lm2doc
  class Theme
    class ScssResource < Hashie::Mash
      
      def file_out(dir, options = {})
        Dir.mktmpdir(nil, Lm2doc.root.join("tmp")) do |tmppath|
          tmpdir = Pathname.new(tmppath)
          `compass compile --css-dir #{tmpdir} --sass-dir #{self.scss_pathname}`
          
          tmpdir.children.each do |child|
            relative_pathname = child.relative_path_from(tmpdir)
            FileUtils.cp(child, File.join(dir, relative_pathname))
          end
        end
      end
      
      def print_out
      end
      
    end
  end
end