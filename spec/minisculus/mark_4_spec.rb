require 'spec_helper'
require 'minisculus/engines'
describe 'Mark_IV' do
  let(:engine) {Engines.mark_IV([4,7])}

  describe '#encode' do
    it 'encodes "The" as "JMl"' do
      engine.encode('The').should == 'JMl'
    end
  end
end
