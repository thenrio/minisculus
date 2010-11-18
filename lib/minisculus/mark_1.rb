require 'minisculus/cypher'
require 'forwardable'

module Engines
  class Mark_I
    def initialize(offset=5)
      @cypher = Cypher::Device::ShiftingWheel.new(offset)
    end
    
    extend Forwardable
    def_delegators :@cypher, :encode, :decode
  end
end