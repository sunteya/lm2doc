# require_relative 'resource/static'
require_relative 'resource/compass'
require 'erb'

module Lm2doc
  
  def self.theme(name)
    require Lm2doc.root.join("themes", name, "init.rb")
    Theme.instance(name)
  end
  
  class Theme
    class << self
      def register(name, theme)
        @pool ||= {}
        @pool[name] = theme
      end
      
      def instance(name)
        @pool ||= {}
        @pool[name]
      end
    end
  end
  
  class Theme
    attr_accessor :dir
    
    def theme_file_pathname(file)
      self.dir.join(file)
    end
    
    def assets
      [
        Resource::Compass.new(self.dir)
      ]
    end
    
    def render(hash)
      erb_file = theme_file_pathname("template.html.erb")
      template = ERB.new(erb_file.read)
      
      @body = hash[:article]
      @title = hash[:title]
      template.result(binding)
    end
    
    def write_assets(dir)
      self.assets.each do |asset|
        asset.write(dir)
      end
    end
    
  end
end