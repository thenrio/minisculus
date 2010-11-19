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

      def crypt(c, _uncrypted=nil)
        @wheel.crypt(c, offset)
      end 
      def uncrypt(c, _uncrypted=nil)
        @wheel.crypt(c, -offset)
      end 
    end
    
    class SelfTurningWheel
      extend Forwardable
      def_delegators :@wheel, :charset
      
      def initialize(charset=Minisculus::DEFAULT_CHARSET)
        @wheel = Minisculus::Wheel.new(charset)
      end
      
      def crypt(c, secret)
        return c if secret.empty?
        @wheel.crypt(c, offset(secret))
      end
      
      def uncrypt(c, secret)
        return c if secret.empty?
        @wheel.crypt(c, -offset(secret))
      end
      
      def offset(secret, i=secret.length - 1)
        charset.index(secret[i]) * 2
      end
    end
  end
end