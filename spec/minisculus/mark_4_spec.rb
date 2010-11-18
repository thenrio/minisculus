require 'spec_helper'
require 'minisculus/engines'
describe Engines.mark_IV do
  let(:engine) {Engines.mark_IV([2, 5])}

  describe '#encode' do
    it 'encodes \'a\' as Mark_II' do
      engine.encode('a').should == 'S'
    end
    it 'encodes \'ab\' as Mark_II' do
      engine.encode('ab').should == 'SG'
    end
  end
end