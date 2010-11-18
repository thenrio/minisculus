require 'minisculus/mark_2'
module Engines
  class Mark_IV
    def initialize(offsets=[4,7])
      @mark_II = Engines::Mark_II.new(offsets)
    end
    
    def encode(secret)
      secret = @mark_II.encode(secret)
    end
  end
end
