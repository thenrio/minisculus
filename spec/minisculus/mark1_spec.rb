require 'spec_helper'
require 'minisculus/mark1'


describe Engines::Mark_I do
  describe '#code' do
    let(:engine) {Engines::Mark_I.new}
    
    it {
      assert {engine.code('ac') == 'fh'}
    }
    it {
      assert {engine.code(' ') == '4'}
    }
  end
end