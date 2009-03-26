module Birdy
  class Bootstrap

    def self.twitter_auth
      @twitter = Twitter::Client.new
      @config = Config.read

      while @twitter.authenticate?(@config[:login], @config[:password]) == false
        puts "Login failed, try again"
        Config.delete

        hl = HighLine.new
        login = hl.ask("login: ")
        password = hl.ask("password: ") {|q| q.echo = '*'}
        Config.write(login, password)

        @config = Config.read
      end
   
      puts "Login success!"
      Twitter::Client.new(:login => @config[:login], :password => @config[:password])
    end

  end
end
