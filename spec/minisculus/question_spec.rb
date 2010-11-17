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
      s = RestClient.get("http://minisculus.edendevelopment.co.uk#{title}", :accept => :json)
      hash = Yajl::Parser.new.parse(s)
      self.content_url = hash['reference-url']
      self.message = hash['question']
    end
  end
end

describe Minisculus::Question do
  describe '#read' do
    let(:question) {Minisculus::Question.new('/start')}
    
    it 'get page from minisculus site' do
      url, message = "oh", "ha"
      stub(RestClient).get('http://minisculus.edendevelopment.co.uk/start', :accept => :json) {
        "{\"reference-url\":\"#{url}\",\"question\":\"#{message}\"}"
      }

      question.read()

      assert {question.content_url == 'oh'}
      assert {question.message == 'ha'}
    end
  end
end