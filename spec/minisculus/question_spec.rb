require 'spec_helper'
require 'restclient'
require 'yajl'

module Minisculus
  class Question
    attr_accessor :title, :content_url, :message
    def initialize(title)
      self.title = title
    end
    
    def read
      s = RestClient.get(question_url, :accept => :json)
      hash = Yajl::Parser.new.parse(s)
      self.content_url = hash['reference-url']
      self.message = hash['question']
    end
    
    def answer(&block)
      answer = yield message
      content = Yajl::Encoder.encode({'answer' => answer})
      RestClient.put(question_url, content, :accept => :json, :content_type => :json)
    end
    
    private
    def question_url
      "http://minisculus.edendevelopment.co.uk#{title}"
    end
  end
end

describe Minisculus::Question do
  describe '#read' do
    let(:question) {Minisculus::Question.new('/14f7ca5f6ff1a5afb9032aa5e533ad95')}
    
    it 'get page from minisculus site' do
      url, message = "oh", "ha"
      mock(RestClient).get('http://minisculus.edendevelopment.co.uk/14f7ca5f6ff1a5afb9032aa5e533ad95', :accept => :json) {
        "{\"reference-url\":\"#{url}\",\"question\":\"#{message}\"}"
      }

      question.read()

      assert {question.content_url == 'oh'}
      assert {question.message == 'ha'}
    end
  end
  
  describe '#answer' do
    let(:question) {
      q = Minisculus::Question.new('/start')
      q.content_url = 'oh'; q.message = 'ha'
      q
    }
    
    it 'put to minisculus site, as json, transformed message using given block' do
      url = 'http://minisculus.edendevelopment.co.uk/start'
      content = '{"answer":"code"}'
      mock(RestClient).put(url, content, :accept => :json, :content_type => :json) {
        '???'
      }
      response = question.answer {|message| 'code'}
      assert {response == '???'}
    end
  end
end