# FileGrabber

Quickly access an index of pages and download a file from each page.

Create an empty specification file with `grab init`.

Then edit it and run with `grab go` (it runs the grabber `'default'`
if you provide no argument).

Try some basic changes like filtering:

```ruby
# vim: ft=ruby
grabber 'default' do
  set_http_basic_username 'mcantor'
  set_http_basic_password ENV['HTTP_BASIC_PASSWORD']
  index 'https://whatever.example.com/files', '.panel-body ul div.row li a'
  # only download log files
  @docpages.select! { |page| page.filename.end_with? '.log' }
  download 'body > div.container > section.document-downloads > a:nth-child(1)'
end
```
