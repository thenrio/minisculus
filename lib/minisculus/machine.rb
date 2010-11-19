module Minisculus
  class Machine
    def initialize(devices)
      @devices = devices
    end
    
    def encode(secret)
      (devices = @devices.dup).each {|d| d.secret = secret if d.respond_to?(:'secret=')}
      map_reduce(@devices.dup, :encode, secret)
    end

    def decode(cryptic)
      cryptic.chars.inject('') {|uncyphered, char|
        uncyphered << @devices.inject(char) {|c, device|
          device.uncrypt(c, uncyphered)
        }
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