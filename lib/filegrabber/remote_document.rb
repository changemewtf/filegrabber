require 'open-uri'

require 'unirest'

module FileGrabber
  class RemoteDocument
    def initialize url
      @params = URI.decode_www_form(url.query).to_h
      url.query = nil
      @url = url
    end

    def download
      Log.info "FROM URL: #{@url}"
      Unirest.get(@url.to_s, parameters: @params).body
    end
  end
end
