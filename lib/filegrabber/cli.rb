require 'thor'

module FileGrabber
  class CLI < Thor
    desc 'init', 'Create an empty config file'
    def init
      FileGrabber.create_default_config
    end

    desc 'get [NAME]', 'Grab files based on a configuration (or default)'
    def get name='default'
      FileGrabber::Grab.new().grab(name)
    end
  end
end
