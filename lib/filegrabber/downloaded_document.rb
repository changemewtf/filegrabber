module FileGrabber
  class DownloadedDocument
    def initialize filename
      @filename = filename
    end

    def download
      clean_if_failed
      if already_downloaded?
        Log.info "Skipping #{@filename} because already downloaded."
      else
        Log.info "DOWNLOAD START: #{@filename}"
        File.open @filename, 'wb' do |file|
          file << yield
        end
        sleep 2
      end
      self
    end

    def size
      File.size(@filename)
    end

    def download_failed?
      if !File.exist? @filename
        false
      else
        File.zero?(@filename) || File.size(@filename) < 1_000
      end
    end

    private

    def clean_if_failed
      File.delete @filename if download_failed?
    end

    def already_downloaded?
      File.exist? @filename
    end
  end
end
