require 'spec_helper'
require 'restclient'

module Minisculus
  class Question
    attr_accessor :title, :content_url, :message
    def initialize(title)
      self.title = title
    end
    def read
      self.content_url = 'http://minisculus.edendevelopment.co.uk/questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html'
      self.message = 'Strong NE Winds!'
    end
  end
end

describe Minisculus::Question do
  describe '#read' do
    let(:question) {Minisculus::Question.new('/start')}
    
    it 'get page from minisculus site' do
      stub(RestClient).get('http://minisculus.edendevelopment.co.uk/start', :accept => :json) {
        "{\"reference-url\":\"/questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html\",\"question\":\"Strong NE Winds!\"}"
      }

      question.read()

      assert {question.content_url == 'http://minisculus.edendevelopment.co.uk/questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html'}
      assert {question.message == 'Strong NE Winds!'}
    end
  end
end