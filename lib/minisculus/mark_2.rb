require 'minisculus/cypher'

module Engines
  class Mark_II
    def initialize(offsets = [2, 5])
      devices = offsets.inject([]) {|acc, o| 
        o = (acc.length+1)*o*(acc.length.even? ? 1 : -1)
        acc << Cypher::Device::ShiftingWheel.new(o)
        acc
      }
      @cypher = Cypher::Device::Serial.new(devices)
    end
    
    extend Forwardable
    def_delegators :@cypher, :encode, :decode
  end
end