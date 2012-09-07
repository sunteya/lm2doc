require_relative '../resource'

require "hashie"
require "tempfile"
require "compass"

module Lm2doc
  class Resource
    class Compass < Resource
      
      attr_accessor :scss_pathname
      
      def initialize(scss_pathname)
        self.scss_pathname = scss_pathname
      end
      
      def write(dir, options = {})
        Lm2doc.mktmpdir do |tmppath|
          tmpdir = Pathname.new(tmppath)
          ::Compass.configuration.sass_path = self.scss_pathname.to_s
          ::Compass.configuration.css_path = tmpdir.to_s
          
          update_project = ::Compass::Commands::UpdateProject.new(Lm2doc.root.join("tmp").to_s, { quiet: true })
          update_project.perform
          
          tmpdir.children.each do |child|
            relative_pathname = child.relative_path_from(tmpdir)
            FileUtils.cp(child, File.join(dir, relative_pathname))
          end
        end
      end
      
    end
  end
end