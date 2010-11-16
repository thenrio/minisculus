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