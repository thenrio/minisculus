require 'minisculus/mark_2'
module Engines
  class Mark_IV
    def initialize(offsets=[4,7])
      @mark_II = Engines::Mark_II.new(offsets)
      @wheel = Engines::Wheel.new
    end
    
    def encode(secret)
      secret = @mark_II.encode(secret)
      secret.chars.inject([]) {|acc, c|
        c = @wheel.move(c).shift(@wheel.letters.index(acc.last) * 2).read if acc.last
        acc << c
      }.join('')
    end
  end
end
