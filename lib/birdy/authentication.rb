module Birdy
  module Authentication

    def authenticate
      @config = Config.new
      @auth = @config.read

      @twitter = Twitter::Client.new

      while @twitter.authenticate?(@auth[:login], @auth[:password]) == false
        @config.delete

        hl = HighLine.new
        login = hl.ask("login: ") {|q| q.readline = true }
        password = hl.ask("password: ") {|q| q.echo = '*'}
        @config.write(login, password)

        @auth = @config.read
      end
   
      Twitter::Client.new(:login => @auth[:login], :password => @auth[:password])
    end

  end
end
