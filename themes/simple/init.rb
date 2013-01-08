require "compass"
require 'compass/exec'

class SimpleTheme < Lm2doc::Theme
  def initialize
    self.dir = Pathname.new(__FILE__).dirname
  end
end

Lm2doc::Theme.register("simple", SimpleTheme.new)

