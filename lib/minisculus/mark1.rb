module Engines
  class Wheel
    @@letters = [
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
      "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
      "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
      "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
      "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
      ".", ",", "?", "!", "'", "\"", " "
    ]
    attr_accessor :letters, :position
    def initialize(letters = @@letters)
      self.letters = letters
    end
    
    def move(letter)
      self.position = letters.index(letter)
      self
    end
    
    def shift(offset)
      self.position = (self.position+offset)%letters.length
      self
    end
    
    def read
      letters[position]
    end
  end
  
  
  class Mark_I
    attr_accessor :position, :wheel
    def initialize(position=5)
      self.position = position
      self.wheel = Wheel.new
    end
    def encode(secret)
      secret.chars.map {|c| wheel.move(c).shift(position).read}.join
    end
  end
end