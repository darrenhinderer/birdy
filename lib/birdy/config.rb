module Birdy

  class Config

    CONFIG_PATH = "#{ENV['HOME']}/.config/birdy/"
    CONFIG_FILE = CONFIG_PATH + "birdy.yml"

    def self.write(login, password)
      FileUtils.mkdir_p CONFIG_PATH

      config = {:login => login, :password => password}

      File.open(CONFIG_FILE, 'w') do |out|
        YAML.dump(config, out)
      end
    end
    
    def self.read
      YAML.load_file(CONFIG_FILE)
    rescue 
      {}
    end

    def self.delete
      File.delete(CONFIG_FILE)
    rescue
      nil
    end

  end

end
