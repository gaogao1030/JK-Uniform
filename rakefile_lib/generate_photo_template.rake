require 'byebug.rb'
include Mote::Helpers
#"+-aaa-+".gsub(/\+\-(.*)\-\+/,'{{\1}}')
#result: {{aaa}}
desc "generate all cameraman template"
task :generate_all_cameraman_template do
  force = ENV["force"] || false
  cameraman_data = YAML::load_file('_data/template/generate_cameraman_template.yml')
  cameraman_data["cameraman"].each do |cameraman|
    ca = cameraman
    name = ca["name"]
    cameraman["gallery"].each do |gallery|
      ga = gallery
      author = ca["author"]
      album  = ga["album"]
      cover  = ga["cover"]
      title  = ga["title"]
      desc   = ga["desc"]
      level  = ga["level"] || ""
      filename ="_cameraman_gallery/cameraman_#{author}_#{album}.html"
      if !File::exists?(filename) or ENV["force"] == "true"
        p "#{filename} generating"
        file = File.new(filename, "w+")
        file.syswrite(mote("mote/cameraman_template.mote",cover: cover,title: title,desc: desc,author: author,album: album,name: name,level: level).gsub(/\+\-(.*)\-\+/,'{{\1}}'))
        file.close
        p "#{filename} generate done"
      else
        p "#{filename} has exist"
      end
    end
  end
end

desc "generate cameraman template"
task :generate_cameraman_template do
  force = ENV["force"] || false
  name = ENV["name"] || "gaogao"
  cameraman_data = YAML::load_file('_data/template/generate_cameraman_template.yml')
  ca = cameraman_data["cameraman"].select{|cm| cm if cm["author"] == name }[0]
  author = ca["author"]
  name = ca["name"]
  ca["gallery"].each do |gallery|
    ga = gallery
    album  = ga["album"]
    cover  = ga["cover"]
    title  = ga["title"]
    desc   = ga["desc"]
    level  = ga["level"] || ""
    filename ="_cameraman_gallery/cameraman_#{author}_#{album}.html"
    if !File::exists?(filename) or ENV["force"] == "true"
      p "#{filename} generating"
      file = File.new(filename, "w+")
      file.syswrite(mote("mote/cameraman_template.mote",cover: cover,title: title,desc: desc,author: author,album: album,name: name,level: level).gsub(/\+\-(.*)\-\+/,'{{\1}}'))
      file.close
      p "#{filename} generate done"
    else
      p "#{filename} has exist"
    end
  end
end

desc "generate all jk template"
task :generate_all_jk_template do
  force = ENV["force"] || false
  name = ENV["name"] || "buble"
  jk_data = YAML::load_file('_data/template/generate_jk_template.yml')
  jk_data["jk"].each do |jk|
    author = jk["author"]
    name = jk["realname"]
    jk["gallery"].each do |gallery|
      ga = gallery
      album  = ga["album"]
      cover  = ga["cover"]
      title  = ga["title"]
      desc   = ga["desc"]
      level  = ga["level"] || ""
      filename ="_jk_gallery/jk_#{author}_#{album}.html"
      if !File::exists?(filename) or ENV["force"] == "true"
        p "#{filename} generating"
        file = File.new(filename, "w+")
        file.syswrite(mote("mote/jk_template.mote",cover: cover,title: title,desc: desc,author: author,album: album,level: level,name: name).gsub(/\+\-(.*)\-\+/,'{{\1}}'))
        file.close
        p "#{filename} generate done"
      else
        p "#{filename} has exist"
      end
    end
  end
end

desc "generate jk template"
task :generate_jk_template do
  force = ENV["force"] || false
  name = ENV["name"] || "buble"
  jk_data = YAML::load_file('_data/template/generate_jk_template.yml')
  jk = jk_data["jk"].select{|cm| cm if cm["author"] == name }[0]
  author = jk["author"]
  name = jk["realname"]
  jk["gallery"].each do |gallery|
    ga = gallery
    album  = ga["album"]
    cover  = ga["cover"]
    title  = ga["title"]
    desc   = ga["desc"]
    level  = ga["level"] || ""
    filename ="_jk_gallery/jk_#{author}_#{album}.html"
    if !File::exists?(filename) or ENV["force"] == "true"
      p "#{filename} generating"
      file = File.new(filename, "w+")
      file.syswrite(mote("mote/jk_template.mote",cover: cover,title: title,desc: desc,author: author,album: album,level: level,name: name).gsub(/\+\-(.*)\-\+/,'{{\1}}'))
      file.close
      p "#{filename} generate done"
    else
      p "#{filename} has exist"
    end
  end
end

desc "generate all party template"
task :generate_all_party_template do
  force = ENV["force"] || false
  name = ENV["name"] || "Party"
  party_data = YAML::load_file('_data/template/generate_party_template.yml')
  party_data["party"].each do |party|
    author = party["author"]
    name = party["realname"]
    party["gallery"].each do |gallery|
      ga = gallery
      album  = ga["album"]
      cover  = ga["cover"]
      title  = ga["title"]
      desc   = ga["desc"]
      level  = ga["level"] || ""
      filename ="_party_gallery/party_#{author}_#{album}.html"
      if !File::exists?(filename) or ENV["force"] == "true"
        p "#{filename} generating"
        file = File.new(filename, "w+")
        file.syswrite(mote("mote/party_template.mote",cover: cover,title: title,desc: desc,author: author,album: album,level: level,name: name).gsub(/\+\-(.*)\-\+/,'{{\1}}'))
        file.close
        p "#{filename} generate done"
      else
        p "#{filename} has exist"
      end
    end
  end
end

desc "generate party template"
task :generate_party_template do
  force = ENV["force"] || false
  name = ENV["name"] || "Party"
  party_data = YAML::load_file('_data/template/generate_party_template.yml')
  party = party_data["party"].select{|cm| cm if cm["author"] == name }[0]
  author = party["author"]
  name = party["realname"]
  party["gallery"].each do |gallery|
    ga = gallery
    album  = ga["album"]
    cover  = ga["cover"]
    title  = ga["title"]
    desc   = ga["desc"]
    level  = ga["level"] || ""
    filename ="_party_gallery/party_#{author}_#{album}.html"
    if !File::exists?(filename) or ENV["force"] == "true"
      p "#{filename} generating"
      file = File.new(filename, "w+")
      file.syswrite(mote("mote/party_template.mote",cover: cover,title: title,desc: desc,author: author,album: album,level: level,name: name).gsub(/\+\-(.*)\-\+/,'{{\1}}'))
      file.close
      p "#{filename} generate done"
    else
      p "#{filename} has exist"
    end
  end
end

desc "generate all template"
task :generate_all_template do
  force = ENV["force"] || false
  system "rake generate_all_cameraman_template force=#{force}"
  system "rake generate_all_jk_template force=#{force}"
  system "rake generate_all_party_template force=#{force}"
end
