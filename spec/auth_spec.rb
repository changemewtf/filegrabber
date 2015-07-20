require 'filegrabber/url'

describe 'HTTP Basic Authentication' do
  it 'should quit when no password is supplied' do
    expect(lambda { FileGrabber::URL.new(nil).get_body }).to raise_error(SystemExit)
  end
end
