# twitter4r 0.3.0 needs time
require 'time'

module Birdy

  class Base

    POLL_TIME_MINUTES = 1 
    CONFIG = "#{ENV['HOME']}/.config/birdy/birdy.yml"

    def initialize
      @alert = GnomeNotifier.new
      @log = Logger.new($stdout)
      bootstrap_twitter
    end

    def poll
      while true
        tweets = get_timeline

        tweets.reverse.each do |tweet|
          image_path = ImageDownload.download_image(tweet.user.profile_image_url)
          @log.info tweet.user.name + ": " + tweet.text
          @alert.show_notice(image_path, tweet.user.name, tweet.text) 
        end

        sleep POLL_TIME_MINUTES * 60
      end
    end

    def get_timeline

      options = {}
      if @last_id
        options[:since_id] = @last_id
      else
        options[:count] = 1
      end

      @log.info "polling"
      tweets = @twitter.timeline_for(:friends, options) 
      @last_id = tweets.first.id if tweets.length > 0
      return tweets
    end

    def bootstrap_twitter
      
      if Config.read.nil?
        hl = HighLine.new
        login = hl.ask("login: ")
        password = hl.ask("password: ") {|q| q.echo = '*'}
        Config.write(login, password)
      end

      @config = Config.read
      
      @twitter = Twitter::Client.new
      if @twitter.authenticate?(@config[:login], @config[:password])
        @log.info "Login success!"
        @twitter = Twitter::Client.new(:login => @config[:login], :password => @config[:password])
      else
        @log.info "Login failed, try again."
        Config.delete
        bootstrap_twitter
      end
    end

  end
end

Twitter::Client.configure do |config|
  config.application_name = 'Birdy'
  config.application_version = Birdy.version
  config.application_url = 'http://github.com/darrenhinderer/birdy'
end
