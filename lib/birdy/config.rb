module Birdy

  class Config

    CONFIG_PATH = "#{ENV['HOME']}/.config/birdy/birdy.yml"

    def self.write(login, password)
      config = {:login => login, :password => password}

      File.open(CONFIG_PATH, 'w') do |out|
        YAML.dump(config, out)
      end
    end
    
    def self.read
      YAML.load_file(CONFIG_PATH)
    rescue 
      nil
    end

    def self.delete
      File.delete(CONFIG_PATH)
    end

  end

end
