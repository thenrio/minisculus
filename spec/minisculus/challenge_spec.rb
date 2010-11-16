require 'spec_helper'
require 'restclient'
require 'yajl'
require 'logger'

module Challenge
  RestClient.log = Logger.new(STDOUT)
  def self.base
    'http://minisculus.edendevelopment.co.uk'
  end

  def show_question_under_jsoned_secret(page)
    RestClient.get("#{base}#{reveal_jsoned_secret(page)}")
  end
  module_function :show_question_under_jsoned_secret

  def reveal_jsoned_secret(page)
    response = RestClient.get("#{base}#{page}", {:accept => :json})
    Yajl::Parser.new.parse(response)['reference-url']
  end
  module_function :reveal_jsoned_secret
end

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
