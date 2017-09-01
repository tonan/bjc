run_home = Dir.home

cookbook_file "#{home}/.ssh/id_rsa.ppk" do
  source 'putty.ppk'
  action :create
end

['C:\tools\cmder',
 'C:\Program Files\Microsoft VS Code\bin'].each do |p|
  windows_path p do
    action :add
  end
end

# Set Pinned Taskbar Items in WS16
cookbook_file 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml' do
  source 'LayoutModification.xml'
end
