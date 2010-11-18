require 'spec_helper'
require 'minisculus/engines'
describe Engines.mark_IV do
  let(:engine) {Engines.mark_IV}

  describe '#encode' do
    it 'encodes "The" as "JMl"' do
      engine.encode('The').should == 'JMl'
    end
  end
end