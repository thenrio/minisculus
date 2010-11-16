require 'spec_helper'
require 'restclient'
require 'ruby-debug'
require 'yajl'

module Challenge
  def self.base
    'http://minisculus.edendevelopment.co.uk'
  end
  
  def get(page)
    response = RestClient.get("#{base}/#{page}", {:accept => :json})
    Yajl::Parser.new.parse(response)
  end
  module_function :get
end

describe Challenge do
  describe "#get" do
    it 'should get in json' do
       response = Challenge.get('start')
       assert {response.class == Hash}
    end
  end
end
