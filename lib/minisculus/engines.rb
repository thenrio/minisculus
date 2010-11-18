require 'minisculus/cypher'

module Engines
  def mark_I(offset=5)
    Cypher::Device::ShiftingWheel.new(offset)
  end
  
  def mark_II(offsets=[2, 5])
    devices = offsets.inject([]) {|acc, o| 
      o = (acc.length+1)*o*(acc.length.even? ? 1 : -1)
      acc << Cypher::Device::ShiftingWheel.new(o)
      acc
    }
    Cypher::Device::Serial.new(devices)    
  end
  
  def mark_IV(offsets=[4,7])
    Cypher::Device::Serial.new([mark_II(offsets), Cypher::Device::Will_III.new])
  end
  
  ['I', 'II', 'IV'].each do |version|
    module_function "mark_#{version}"
  end
end