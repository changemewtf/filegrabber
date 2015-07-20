module FileGrabber
  CONFIG_FILENAME = 'Grabfile'

  def self.create_default_config
    if File.exist? CONFIG_FILENAME
      FileGrabber::Log.error "Can't overwrite existing config file."
    else
      File.open CONFIG_FILENAME, 'w+' do |file|
        file.write <<-EOF.gsub(/^\s{10}/, '')
          # vim: ft=ruby
          grabber 'default' do
            set_http_basic_username 'admin'
            set_http_basic_password ENV['HTTP_BASIC_PASSWORD']
            index 'http://www.example.com/files', 'div ul li a'
            download 'div a'
          end
        EOF
      end
    end
  end

  class Grab
    def initialize
      @grabs = {}
      instance_eval File.read(CONFIG_FILENAME)
    end

    def grabber name, &block
      @grabs[name] = block
    end

    def grab name
      instance_eval &@grabs[name]
    end

    def set_http_basic_username value
      HTTP_BASIC_AUTH[:username] = value
    end

    def set_http_basic_password value
      HTTP_BASIC_AUTH[:password] = value
    end

    def index url, link_selector
      @docpages = IndexPage.new(url, 'index.html')
        .links(link_selector)
        .map { |link| DocumentPage.new(link) }
    end

    def download link_selector
      @docpages.each do |page|
        link = page.link(link_selector)
        DownloadedDocument.new(page.filename).download do
          RemoteDocument.new(link).download
        end.tap do |doc|
          Log.info "Done. File size: #{doc.size}"
          if doc.download_failed?
            Log.warn "Download failed. Retry on next run."
          end
        end
      end
    end
  end
end
