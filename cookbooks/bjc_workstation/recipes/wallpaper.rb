wallpaper = "#{ENV['PUBLIC']}\\Pictures\\wallpaper.jpg"

cookbook_file wallpaper do
  source 'wallpaper.jpg'
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
