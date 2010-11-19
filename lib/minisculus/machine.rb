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
    
    private
    def map_reduce(devices, method, secret)
      device = devices.shift
      return secret unless device
      map_reduce(devices, method, device.send(method, secret))
    end       
  end
end