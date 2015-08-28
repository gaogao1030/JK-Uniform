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
