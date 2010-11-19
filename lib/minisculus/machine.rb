module Minisculus
  class Machine
    def initialize(devices)
      @devices = devices
    end

    def decode(cryptic)
      cryptic.chars.inject('') {|secret, c|
        secret << uncrypt(c, secret)
      }
    end

    def uncrypt(char, secret)
      @devices.inject(char) {|c, device|
        device.uncrypt(c, secret)
      }      
    end

    def encode(secret)
      processed=''
      secret.chars.inject('') {|cryptic, c|
        cryptic << crypt(c, processed)
        processed << c
        cryptic
      }
    end

    def crypt(char, secret)
      @devices.inject(char) {|c, device|
        device.crypt(c, secret)
      }      
    end      
  end
end