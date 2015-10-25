desc "fetch cameraman Album"
task :fetch_cameraman_album do
  name = ENV["name"] || "gaogao"
  system "rake fetch_member bucket='photo' name=#{name} member_type='cameraman'"
end

desc "fetch JK Album"
task :fetch_jk_album do
  name = ENV["name"] || "Virgo"
  system "rake fetch_member bucket='photo' name=#{name} member_type='jk'"
end

desc "fetch Party Album"
task :fetch_party_album do
  name = ENV["name"] || "Party"
  system "rake fetch_member bucket='photo' name=#{name} member_type='party'"
end

desc "fetch all cameraman album"
task :fetch_all_cameraman_album do
  cameramans = YAML::load_file('qiniu_fetch_data.yml')["cameraman"]
  cameramans.each do |cameraman|
    system "rake fetch_cameraman_album name=#{cameraman['name']}"
  end
end

desc "fetch all jk album"
task :fetch_all_jk_album do
  jks = YAML::load_file('qiniu_fetch_data.yml')["jk"]
  jks.each do |jk|
    system "rake fetch_jk_album name=#{jk['name']}"
  end
end

desc "fetch all party album"
task :fetch_all_party_album do
  parties = YAML::load_file('qiniu_fetch_data.yml')["party"]
  parties.each do |party|
    system "rake fetch_party_album name=#{party['name']}"
  end
end
