require 'minisculus/wheel'
require 'forwardable'

module Minisculus
  module Cypher
    class ShiftingWheel
      extend Forwardable
      def_delegators :@wheel, :charset
      
      attr_accessor :offset
      def initialize(offset=5, charset=Minisculus::DEFAULT_CHARSET)
        self.offset = offset
        @wheel = Minisculus::Wheel.new(charset)
      end
      
      def encode(informations, offset=self.offset)
        informations.chars.inject('') {|acc,c| acc << crypt(c, offset)}
      end
      def decode(informations)
        encode(informations, -offset)
      end
      
      protected
      def crypt(c, offset)
        @wheel.move(c).shift(offset).read
      end   
    end
    
    class SelfTurningWheel < ShiftingWheel
      attr_accessor :secret
      def initialize(charset=Minisculus::DEFAULT_CHARSET)
        super(0, charset)
      end
      
      def encode(informations)
        self.offset = 0
        informations.chars.inject('') {|acc, c|
          acc << crypt(c, offset)
          turn(acc.length - 1)
          acc
        }
      end
      
      private
      def turn(index)
        self.offset = (charset.index(@secret[index]) * 2) 
      end
    end
    
    class Serial
      def initialize(devices)
        @devices = devices
      end
      
      def encode(secret)
        (devices = @devices.dup).each {|d| d.secret = secret if d.respond_to?(:'secret=')}
        map_reduce(@devices.dup, :encode, secret)
      end

      def decode(cryptic)
        'abc'
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