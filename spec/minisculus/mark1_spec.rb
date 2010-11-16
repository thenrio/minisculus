require 'spec_helper'

module Engines
  class Mark_I
    attr_accessor :position
    def initialize(position=5)
      self.position = position
    end
    def code(secret)
      secret.chars.map {|c| letters[(letters.index(c) + position)%letters.length]}.join
    end
    
    private
    def letters
      @@letters ||= [
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
        "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
        "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
        ".", ",", "?", "!", "'", "\"", " "
      ]
    end
  end
end

describe Engines::Mark_I do
  describe '#code' do
    let(:engine) {Engines::Mark_I.new}
    
    it {
      assert {engine.code('ac') == 'fh'}
    }
    it {
      assert {engine.code(' ') == '4'}
    }
  end
end