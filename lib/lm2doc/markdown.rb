require_relative 'source'
require "kramdown"
require "nokogiri"

module Lm2doc
  
  class Markdown < Source
    
    def convert
      html = Kramdown::Document.new(self.content, 
        :coderay_line_numbers => :table
      ).to_html
      
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      # down_heading(doc)
      doc.to_html
    end
    
    def down_heading(doc)
      doc.css("h3").each {|n| n.name = "h4" }
      doc.css("h2").each {|n| n.name = "h3" }
      doc.css("h1").each {|n| n.name = "h2" }
    end
    
    class << self
      def perfer_exts
        %w[ .md ]
      end
    end
    
  end
end