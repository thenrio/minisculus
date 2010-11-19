require 'spec_helper'
require 'minisculus/engines'


describe 'Mark_I' do
  let(:engine) {Minisculus::Engines.mark_I(5)}
  describe '#encode' do
    it {
      assert {engine.encode('ac') == 'fh'}
    }
    it {
      assert {engine.encode(' ') == '4'}
    }
  end
end