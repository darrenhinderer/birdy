require 'time' # twitter4r 0.3.0 needs time

module Birdy

  class Base

    def initialize
      @alert = GnomeNotifier.new
    end

    def poll
      @twitter = Bootstrap.twitter_auth

      while true
        tweets.reverse.each do |tweet|
          image_path = ImageDownload.download(tweet.user.profile_image_url)
          @alert.show_notice(image_path, tweet.user.name, tweet.text) 
        end

        sleep 60
      end
    end

    def tweets
      options = {}
      if @last_tweet_id
        options[:since_id] = @last_tweet_id
      else
        options[:count] = 1
      end

      timeline = @twitter.timeline_for(:friends, options) 
      if timeline.length > 0
        @last_tweet_id = timeline.first.id 
      end

      timeline
    end

  end
end
