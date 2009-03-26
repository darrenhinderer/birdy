require 'time' # twitter4r 0.3.0 needs time
require File.join(File.expand_path(File.dirname(__FILE__)), 'authentication')
require File.join(File.expand_path(File.dirname(__FILE__)), 'image_download')

module Birdy

  class Base
    include Birdy::Authentication
    include Birdy::ImageDownload

    def initialize
      @twitter = authenticate
      @alert = GnomeNotifier.new
      poll
    end

    def poll
      while true
        tweets.reverse.each do |tweet|
          image_path = download(tweet.user.profile_image_url)
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
