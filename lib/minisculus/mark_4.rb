require 'minisculus/mark_2'
require 'minisculus/cypher'

module Engines
  class Mark_IV
    def initialize(offsets=[4,7])
      @cypher = Cypher::Device::Serial.new([Engines::Mark_II.new(offsets), Cypher::Device::Will_III.new])
    end
    
    extend Forwardable
    def_delegators :@cypher, :encode, :decode
  end
end
