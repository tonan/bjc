# encoding: utf-8
# copyright: 2016, Chef Software, Inc.
# license: All rights reserved

title 'Basic Apache Webserver Security'

control 'httpd-1.0' do
  impact 1.0

  title 'Apache Directory Listing Configuration'
  desc 'The Apache2 web server should not allow directories to be indexed'

  describe file('/etc/apache2/apache2.conf') do
    its(:content) { should_not match(/^\s+Options.*[\+\s]Indexes/) }
  end
end
