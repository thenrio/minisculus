require 'minisculus/cypher'

module Minisculus
  module Engines
    def mark_I(offset=6)
      Minisculus::Machine.new([Minisculus::Cypher::ShiftingWheel.new(offset)])
    end

    def mark_II(offsets=[9, 3])
      devices = offsets.inject([]) {|acc, o| 
        o = (acc.length+1)*o*(acc.length.even? ? 1 : -1)
        acc << Minisculus::Cypher::ShiftingWheel.new(o)
        acc
      }
      Minisculus::Machine.new(devices)    
    end

    def mark_IV(offsets=[4,7])
      Minisculus::Machine.new([mark_II(offsets), Minisculus::Cypher::SelfTurningWheel.new])
    end

    ['I', 'II', 'IV'].each do |version|
      module_function "mark_#{version}"
    end
  end
end
