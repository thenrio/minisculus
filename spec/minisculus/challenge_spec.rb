require 'spec_helper'
require 'restclient'
require 'ruby-debug'
require 'yajl'

module Challenge
  def self.base
    'http://minisculus.edendevelopment.co.uk'
  end

  def get_json(page)
    response = RestClient.get("#{base}/#{page}", {:accept => :json})
    Yajl::Parser.new.parse(response)
  end
  module_function :get_json
end

describe Challenge do
  describe "#get_json" do
    it 'should get a json hash' do
       response = Challenge.get_json('start')
       assert {response['reference-url'] == '/questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html'}
    end
  end
  
  describe '#show' do
    it 'should show the page under reference-url token' do
      
    end
  end
  
end
