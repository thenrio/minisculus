
Challenge start
---------------
first question is http://minisculus.edendevelopment.co.uk/14f7ca5f6ff1a5afb9032aa5e533ad95

Read and answer to questions
----------------------------
can use in irb Minisculus::Question.new(uri), where uri is relative to site

Minisculus::Question

* can be read, that will get json and set instance variable (message, uri)
* can answer with an instance evaled block


Here is an example

    ~/src/ruby/minisculus/lib (master)$ irb
    ruby-1.9.2-p0 > $LOAD_PATH.unshift '.'
    ruby-1.9.2-p0 > require 'minisculus'
    ruby-1.9.2-p0 > Minisculus::Question.new('14f7ca5f6ff1a5afb9032aa5e533ad95').read.answer {Minisculus::Engines.mark_I.encode(message)}
     => #<Minisculus::Question:0x000001009362e0 @params={:headers=>{"Accept"=>"application/json", "Content-Type"=>"application/json"}}, @uri="2077f244def8a70e5ea758bd8352fcd8">
    
How to read next question ?
---------------------------
Use either 

* Minisculus::Question#instructions once read
* Minisculus::Question#show once read

