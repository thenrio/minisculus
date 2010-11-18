require 'minisculus/wheel'

module Cypher
  module Device
    class ShiftingWheel
      attr_accessor :offset, :wheel
      def initialize(offset=5)
        self.offset = offset
        self.wheel = Engines::Wheel.new
      end
      
      def encode(secret, offset=self.offset)
        secret.chars.inject('') {|acc,c| acc << wheel.move(c).shift(offset).read}
      end
      def decode(secret)
        encode(secret, -offset)
      end      
    end
  end
end