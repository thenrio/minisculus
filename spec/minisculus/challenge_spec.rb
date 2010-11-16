require 'spec_helper'
require 'minisculus/challenge'

describe Challenge do
  describe "#reveal_jsoned_secret" do
    it 'should get a json hash and return secret key' do
       assert {Challenge.reveal_jsoned_secret('/start') == '/questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html'}
    end
  end
  
  describe '#show_question_under_jsoned_secret' do
    it 'should show the page under reference-url token' do
      page = Challenge.show_question_under_jsoned_secret('/start')
      assert {page =~ /FIRST CHALLENGE/}
    end
  end
end
