require 'open-uri'

require 'nokogiri'

module FileGrabber
  class IndexPage
    def initialize url, filename
      @url = url
      @filename = filename
    end

    def links selector
      Nokogiri::HTML(html)
        .css(selector)
        .map do |link|
          new_link = link.dup
          new_link.set_attribute 'href', URI.join(@url, link['href'])
          new_link
        end
    end

    private

    def html
      if !File.exist?(@filename) || File.zero?(@filename)
        File.open @filename, 'w+' do |f|
          f.write FileGrabber::URL.new(@url).get_body
        end
      end
      File.read @filename
    end
  end
end
