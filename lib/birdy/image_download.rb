module Birdy
  module ImageDownload

    IMAGES = "#{ENV['HOME']}/.config/birdy/images/"
    ONE_DAY = 24 * 60 * 60

    def download image_url
      FileUtils.mkdir_p IMAGES

      uri = URI.parse(image_url)
      Net::HTTP.start(uri.host) do |http|
        response = http.get(uri.path)
        @filename = IMAGES + File.split(uri.path)[1]
        yesterday = Time.now - ONE_DAY

        unless File.exists?(@filename) && File.mtime(@filename) > yesterday
          open(@filename, "wb") do |file|
            file.write(response.body)
          end
        end
      end

      @filename
    end

  end
end
