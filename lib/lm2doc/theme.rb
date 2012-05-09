require_relative 'theme/static_resource'
require_relative 'theme/content_resource'
require_relative 'theme/compass_resource'
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
    
    attr_accessor :dir
    
    def theme_file_pathname(file)
      self.dir.join(file)
    end
    
    def assets
      [
        CompassResource.new(
          :scss_pathname => self.dir.to_s
        )
      ]
    end
    
    def render(hash)
      erb_file = theme_file_pathname("template.html.erb")
      template = ERB.new(erb_file.read)
      
      @body = hash[:article]
      @title = hash[:title]
      template.result(binding)
    end
    
    def markup_resource(dir, relative_pathname)
      extname = relative_pathname.extname
      markup_class = Source.subclasses.find {|clazz| clazz.perfer_exts.include?(extname) }
      
      if markup_class
        text = dir.join(relative_pathname).read
        html = markup_class.new(:content => text).as_html
        content = render(:article => html, :title => "foo")
        
        ContentResource.new(relative_pathname.to_s.sub(extname, ".html"), content)
      end
    end
    
    def build_resources(file_or_dir)
      resources = [] + self.assets
      
      if File.directory?(file_or_dir)
        dir = Pathname.new(file_or_dir)
        files = Pathname.new(file_or_dir).children
      else
        dir = Pathname.new(file_or_dir).dirname
        files = [ Pathname.new(file_or_dir) ]
      end
      
      files.each do |child|
        relative_pathname = child.relative_path_from(dir)
        
        resource = markup_resource(dir, relative_pathname)
        if resource
          resources.unshift(resource)
        else
          resources << StaticResource.new(dir.to_s, relative_pathname.to_s)
        end
      end
      
      resources
    end
    
    def generate(file_or_dir, options = {})
      resources = build_resources(file_or_dir)
      
      resources.each do |resource|
        if options[:out]
          resource.file_out(options[:out], options)
        else
          out = resource.print_out
          puts out if out
        end
      end
    end
    
  end
end