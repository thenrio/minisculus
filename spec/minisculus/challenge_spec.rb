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
  
  def answer_to_jsoned_secret(question, answer)
    answer = Yajl::Encoder.encode({'answer' => answer})
    RestClient.put("#{Challenge.base}#{question}", answer, :content_type => :json, :accept => :json)
  end
  
  describe '#answer_to_jsoned_secret' do
    it 'receive a redirect code for a correct answer' do
      response = answer_to_jsoned_secret('/questions/14f7ca5f6ff1a5afb9032aa5e533ad95', 'Yzxutm5TK5cotjy2')
      pp response
    end
  end
end
