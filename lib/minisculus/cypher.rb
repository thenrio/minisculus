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
    
    class Will_III
      def initialize(charset=Engines::Wheel.letters)
        @wheel = Engines::Wheel.new(charset)
      end
      
      def encode(secret)
        secret
      end
    end
    
    class Serial
      def initialize(devices)
        @devices = devices
      end
      
      def encode(secret)
        map_reduce(@devices.dup, :encode, secret)
      end

      private
      def map_reduce(devices, method, secret)
        device = devices.shift
        return secret unless device
        map_reduce(devices, method, device.send(method, secret))
      end
    end
  end
end