require 'minisculus/wheel'
require 'minisculus/machine'
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
        informations.chars.inject('') {|acc,c| acc << @wheel.crypt(c, offset)}
      end
      def decode(informations)
        encode(informations, -offset)
      end
 
      def uncrypt(c, _uncrypted)
        @wheel.crypt(c, -offset)
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
          acc << @wheel.crypt(c, offset)
          turn(acc.length - 1)
          acc
        }
      end
      
      def crypt(c, secret)
        c
      end
      
      def uncrypt(c, uncrypted)
        return c if uncrypted.empty?
        @wheel.crypt(c, -hoffset(uncrypted.length-1, uncrypted))
      end
      
      def hoffset(i, secret)
        charset.index(secret[i]) * 2
      end
      
      private
      def turn(index)
        self.offset = (charset.index(@secret[index]) * 2) 
      end
      
    end
  end
end