require 'open-uri'

require 'nokogiri'

module FileGrabber
  class DocumentPage
    attr_reader :filename

    def initialize link
      @filename = link.inner_text
      @url = link['href']
    end

    def link selector
      URI.parse download_anchor(selector)['href']
    end

    private

    def download_anchor selector
      Nokogiri::HTML(html)
        .css(selector)
        .first
    end

    def html
      FileGrabber::URL.new(@url).get_body
    end
  end
end
