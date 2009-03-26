module Birdy
  class ImageDownload

    IMAGES = "#{ENV['HOME']}/.config/birdy/images/"
    ONE_DAY = 24 * 60 * 60

    def self.download_image image_url
      uri = URI.parse(image_url)
      Net::HTTP.start(uri.host) do |http|
        resp = http.get(uri.path)
        filename = IMAGES + File.split(uri.path)[1]
        yesterday = Time.now - ONE_DAY

        unless File.exists?(filename) && File.mtime(filename) > yesterday
          open(filename, "wb") do |file|
            file.write(resp.body)
          end
        end
        return filename
      end
    end

  end
end
