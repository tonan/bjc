wallpaper = "#{ENV['PUBLIC']}\\Pictures\\wallpaper.png"

cookbook_file wallpaper do
  source 'wallpaper.png'
end

directory "#{ENV['SystemRoot']}\\System32\\GroupPolicy\\User" do
  recursive true
end

cookbook_file "#{ENV['SystemRoot']}\\System32\\GroupPolicy\\User\\Registry.pol" do
  source 'Registry.pol'
end

cookbook_file "#{ENV['SystemRoot']}\\System32\\GroupPolicy\\gpt.ini" do
  source 'gpt.ini'
end
