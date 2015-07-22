require 'filegrabber/document_page'

describe FileGrabber::DocumentPage do
  it 'extracts an href from HTML' do
    html = '<div><a href="foo">bar</a></div>'
  end
end
