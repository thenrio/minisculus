require 'minisculus/wheel'

module Engines
  class Mark_II
    def initialize(offsets = [2, 5])
      @offsets = offsets
      @wheel = Engines::Wheel.new
    end
    
    def encode(secret)
      _encode(secret, @offsets)
    end
    
    def _encode(secret, offsets)
      debugger
      offset = offsets.shift
      if offset
        s = secret.chars.inject('') {|acc, c| acc << @wheel.move(c).shift(offset).read}
        _encode(s, offsets)
      else
        secret
      end
    end
  end
end