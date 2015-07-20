module FileGrabber
  HTTP_BASIC_AUTH = {username: nil, password: nil}

  class URL
    def initialize url
      @url = url
    end

    def get_body
      if HTTP_BASIC_AUTH[:password].nil?
        puts "Please provide a basic auth password."
        exit 1
      end
      Unirest.get(@url.to_s, auth: unirest_auth).body
    end

    private

    def unirest_auth
      {
        user: HTTP_BASIC_AUTH[:username],
        password: HTTP_BASIC_AUTH[:password]
      }
    end
  end
end
