require 'spec_helper'
require 'minisculus/question'

describe Minisculus::Question do
  describe '#read' do
    let(:question) {Minisculus::Question.new('/1')}
    
    it 'get page from minisculus site' do
      url, message = "oh", "ha"
      mock(Typhoeus::Request).get('http://minisculus.edendevelopment.co.uk/1', :headers => Minisculus::Question.headers) {
        "{\"reference-url\":\"#{url}\",\"question\":\"#{message}\"}"
      }

      question.read()

      assert {question.content_url == 'oh'}
      assert {question.message == 'ha'}
    end
  end
  
  describe '#answer' do
    let(:question) {
      q = Minisculus::Question.new('/234')
      q.content_url = 'oh'; q.message = 'ha'
      q
    }
    
    it 'put to minisculus site, as json, transformed message using given block' do
      url = 'http://minisculus.edendevelopment.co.uk/234'
      content = '{"answer":"code"}'
      mock(Typhoeus::Request).put(url, :body => content, :headers => Minisculus::Question.headers) {
        Typhoeus::Response.new(:code => 303)
      }
      response = question.answer {|message| 'code'}
      assert {response.code == 303}
    end
  end
end