require 'minisculus/mark_1'

module Engines
  class Mark_II
    def initialize(offsets = [2, 5])
      @marks = offsets.inject([]) {|acc, o| 
        o = (acc.length+1)*o*(acc.length.even? ? 1 : -1)
        acc << Engines::Mark_I.new(o)
        acc
      }
    end
    
    def encode(secret)
      _encode(secret, @marks.dup)
    end
    
    def _encode(secret, marks)
      mark = marks.shift
      if mark
        _encode(mark.encode(secret), marks)
      else
        secret
      end
    end
  end
end