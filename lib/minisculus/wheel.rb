module Minisculus
  DEFAULT_CHARSET = [
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
    "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
    ".", ",", "?", "!", "'", "\"", " "
  ].freeze
  
  class Wheel
    attr_accessor :charset, :position
    def initialize(charset = DEFAULT_CHARSET)
      self.charset = charset
    end
    
    def move(letter)
      self.position = charset.index(letter)
      self
    end
    
    def shift(offset)
      self.position = (self.position+offset)%charset.length
      self
    end
    
    def read
      charset[position]
    end
  end
end