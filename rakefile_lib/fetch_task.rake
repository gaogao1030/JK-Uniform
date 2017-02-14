task :fetch_qiniu do
  Dir["initializers/*"].each do |filename|
    require "./"+filename
  end
  bucket = ENV["bucket"] || "jk-uniform"
  path = ENV['path']
  prefix = ENV['prefix'] || ""
  p "fetching <<#{prefix}>> galley"
  host = {
    "image":"7xl9zk.com1.z0.glb.clouddn.com",
    "jk-uniform":"7xl9ad.com1.z0.glb.clouddn.com",
    "photo": "7xj4vj.com1.z0.glb.clouddn.com"
  }
  #test = YAML::load_file('_data/qiniu/image/test.yml')
  result = Qiniu.list({:bucket=>bucket,:prefix => prefix})
  abort "fetch faild because #{bucket} isn't exist" if result[0] != 200
  items  = result[1]["items"]
  data = items.map{|item| { :url => "http://"+host[bucket.to_sym]+"/"+item["key"]  } }
  dir_path = path.split("/")
  FileUtils::mkdir_p dir_path.slice(0,dir_path.length-1).join("/")
  File.open(path,"w"){ |f| f.write data.to_yaml.gsub(":url","url") }
  p prefix+"fetch done"
end

desc "fetch member Album collection"
task :fetch_member do
  bucket = ENV["bucket"] || "photo"
  name = ENV["name"] || "gaogao"
  member_type = ENV["member_type"] || "cameraman"
  qiniu_fetch_data = YAML::load_file('qiniu_fetch_data.yml')
  member = qiniu_fetch_data[member_type].select{|cm| cm if cm["name"]== name }[0]
  gallery = member["gallery"]
  gallery.each do |g|
    system "rake fetch_qiniu bucket='#{bucket}' path='_data/qiniu/photos/#{member_type}/#{member["name"]}/#{g}.yml' prefix='#{member["name"]}/#{g}/'"
  end
end

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
