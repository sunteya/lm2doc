require "hashie"
require "tempfile"
require "fileutils"

module Lm2doc
  class Theme
    class CompassResource < Hashie::Mash
      
      def file_out(dir, options = {})
        Dir.mktmpdir(nil, Lm2doc.root.join("tmp")) do |tmppath|
          tmpdir = Pathname.new(tmppath)
          Compass.configuration.sass_path = self.scss_pathname
          Compass.configuration.css_path = tmpdir.to_s
          update_project = Compass::Commands::UpdateProject.new(Lm2doc.root.join("tmp").to_s, {})
          update_project.perform
          
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