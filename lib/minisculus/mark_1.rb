require 'minisculus/wheel'

module Engines
  class Mark_I
    attr_accessor :position, :wheel
    def initialize(position=5)
      self.position = position
      self.wheel = Wheel.new
    end
    def encode(secret, position = self.position)
      secret.chars.inject('') {|acc,c| acc << wheel.move(c).shift(position).read}
    end
    def decode(secret)
      encode(secret, -self.position)
    end
  end
end