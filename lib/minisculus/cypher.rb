require 'minisculus/wheel'

module Minisculus
  module Cypher
    class ShiftingWheel
      attr_accessor :offset
      def initialize(offset=5, charset=Minisculus::DEFAULT_CHARSET)
        self.offset = offset
        @wheel = Minisculus::Wheel.new(charset)
      end
      
      def encode(secret, offset=self.offset)
        secret.chars.inject('') {|acc,c| acc << crypt(c, offset)}
      end
      def decode(secret)
        encode(secret, -offset)
      end
      
      protected
      def crypt(c, offset)
        @wheel.move(c).shift(offset).read
      end   
    end
    
    class SelfTurningWheel < ShiftingWheel
      def initialize(charset=Minisculus::DEFAULT_CHARSET)
        super(0, charset)
      end
      
      def encode(secret)
        self.offset = 0
        secret.chars.inject('') {|acc, c|
          acc << crypt(c, offset)
          turn(acc[-1])
          acc
        }
      end
      
      private
      def turn(char)
        self.offset += @wheel.charset.index(char) * 2
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