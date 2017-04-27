run_home = Dir.home

cookbook_file "#{home}/.ssh/id_rsa.ppk" do
  source 'putty.ppk'
  action :create
end

[ "#{run_home}\\AppData\\Local\\atom\\bin",
  'C:\tools\cmder',
  'C:\Program Files (x86)\Microsoft VS Code\bin'].each do |p|
  windows_path p do
    action :add
  end
end
