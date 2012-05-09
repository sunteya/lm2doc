require "compass"
require "bootstrap-sass"
require 'compass/exec'

class BootstrapTheme < Lm2doc::Theme
  def initialize
    self.dir = Pathname.new(__FILE__).dirname
  end
end

Lm2doc::Theme.register("bootstrap", BootstrapTheme.new)

