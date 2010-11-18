
Challenge start
---------------

first question is http://minisculus.edendevelopment.co.uk/14f7ca5f6ff1a5afb9032aa5e533ad95

    ruby-1.9.2-p0 > q1 = Minisculus::Question.new('14f7ca5f6ff1a5afb9032aa5e533ad95').read
     => #<Minisculus::Question:0x00000100a11f20 @params={:headers=>{"Accept"=>"application/json", "Content-Type"=>"application/json", "User-Agent"=>"Typhoeus - http://github.com/pauldix/typhoeus/tree/master"}}, @uri="14f7ca5f6ff1a5afb9032aa5e533ad95", @instructions="questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html", @message="Strong NE Winds!"> 
    ruby-1.9.2-p0 > q2 = q1.answer {Engines.mark_I.encode(message)}.read
     => #<Minisculus::Question:0x000001009f4f10 @params={:headers=>{"Accept"=>"application/json", "Content-Type"=>"application/json", "User-Agent"=>"Typhoeus - http://github.com/pauldix/typhoeus/tree/master"}}, @uri="2077f244def8a70e5ea758bd8352fcd8", @instructions="questions/2077f244def8a70e5ea758bd8352fcd8.html", @message="The Desert Fox will move 30 tanks to Calais at dawn"> 
     ruby-1.9.2-p0 > q3 = q2.answer {Engines.mark_II.encode(message)}.read
      => #<Minisculus::Question:0x000001019628a8 @params={:headers=>{"Accept"=>"application/json", "Content-Type"=>"application/json", "User-Agent"=>"Typhoeus - http://github.com/pauldix/typhoeus/tree/master"}}, @uri="36d80eb0c50b49a509b49f2424e8c805", @instructions="questions/36d80eb0c50b49a509b49f2424e8c805.html", @message="The white cliffs of Alghero are visible at night">
      ruby-1.9.2-p0 > q4 = q3.answer {Engines.mark_IV.encode message}.read
       => #<Minisculus::Question:0x000001009aa898 @params={:headers=>{"Accept"=>"application/json", "Content-Type"=>"application/json", "User-Agent"=>"Typhoeus - http://github.com/pauldix/typhoeus/tree/master"}}, @uri="4baecf8ca3f98dc13eeecbac263cd3ed", @instructions="questions/4baecf8ca3f98dc13eeecbac263cd3ed.html", @message="WZyDsL3u'0TfxP06RtSSF 'DbzhdyFIAu2 zF f5KE\"SOQTNA8A\"NCKPOKG5D9GSQE'M86IGFMKE6'K4pEVPK!bv83I">


