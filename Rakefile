require 'time'
require 'pathname'
require "irb"
require 'irb/completion'
require "liquid.rb"
require 'qiniu.rb'
require 'yaml.rb'
require 'jekyll'
require 'fileutils'

local_repo = "jk.gaogao.ninja"
remote_repo = "JK-Uniform"
#rake server host="localhost" p="4000"

task :fetch_qiniu do
  Dir["initializers/*"].each do |filename|
    require "./"+filename
  end
  bucket = ENV["bucket"] || "jk-uniform"
  path = ENV['path']
  prefix = ENV['prefix'] || ""
  host = {
    "image":"7xl9zk.com1.z0.glb.clouddn.com",
    "jk-uniform":"7xl9ad.com1.z0.glb.clouddn.com"
  }
  #test = YAML::load_file('_data/qiniu/image/test.yml')
  result = Qiniu.list({:bucket=>bucket,:prefix => prefix})
  abort "fetch faild because #{bucket} isn't exist" if result[0] != 200
  items  = result[1]["items"]

  data = items.map{|item| { :url => "http://" + host[bucket.to_sym]+ "/" + item["key"]  } }
  dir_path = path.split("/")
  FileUtils::mkdir_p dir_path.slice(0,dir_path.length-1).join("/")
  File.open(path,"w"){ |f| f.write data.to_yaml.gsub(":url","url") }
end

desc "take image bucket jpg"
task :take_image_bucket_jpg do
  system "rake fetch_qiniu bucket='image' path='_data/qiniu/image/test.yml'"
end

task :console do |t,args|
  env = ENV['APP_ENV'] || 'development'
  puts "Loading #{env} environment"
  #require 'qiniu-rs.rb'
  path = Pathname.new(File.dirname(__FILE__)).realpath.to_s
  unless File.exist?("qiniu.yml")
    abort "can't find qiniu.yml,please make sure #{path}/qiniu.yml exist"
  end
  Dir["initializers/*"].each do |filename|
    require "./"+filename
  end
  Dir["_plugins/*"].each do |filename|
    require "./"+filename
  end
  # 必须执行 ARGV.clear，不然 rake 后面的参数会被带到 IRB 里面
  ARGV.clear
  IRB.start
end

desc "call qiniu list api"
task "qiniu_list" do
  p "hi "
end

#Usage: rake post title="A Title" [date="2014-04-14"] desc "Create a new post"
desc "create a new post"
task :post do
 unless FileTest.directory?('./_posts')
   abort("rake aborted: '_posts' directory not found.")
 end
 title = ENV["title"] || "new-post"
 slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
 begin
   date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now)
   .strftime('%Y-%m-%d')
 rescue Exception => e
   puts "Error: date format must be YYYY-MM-DD!"
   exit -1
 end
 filename = File.join('.', '_posts', "#{date}-#{slug}.md")
 if File.exist?(filename)
   abort("rake aborted: #{filename} already exists.")
 end
 puts "Creating new post: #{filename}"
 open(filename, 'w') do |post|
   post.puts "---"
   post.puts "layout: post"
   post.puts "title: \"#{title.gsub(/-/,' ')}\""
   post.puts "date: #{date}"
   post.puts "categories:"
   post.puts "---"
 end
end

desc "Create a new draft"
task :draft do
 unless FileTest.directory?('./_drafts')
   abort("rake aborted: '_posts' directory not found.")
 end
 title = ENV["title"] || "new-post"
 slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
 begin
   date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now)
   .strftime('%Y-%m-%d')
 rescue Exception => e
   puts "Error: date format must be YYYY-MM-DD!"
   exit -1
 end
 filename = File.join('.', '_drafts', "#{date}-#{slug}.md")
 if File.exist?(filename)
   abort("rake aborted: #{filename} already exists.")
 end
 puts "Creating new post: #{filename}"
 open(filename, 'w') do |post|
   post.puts "---"
   post.puts "layout: post"
   post.puts "title: \"#{title.gsub(/-/,' ')}\""
   post.puts "date: #{date}"
   post.puts "categories:"
   post.puts "---"
 end
end

desc "fetch repo from github"
task :fetch_repo do
  repo = ENV["repo"]
  url= "git@github.com:gaogao1030/#{repo}"
  unless FileTest.directory?("../#{local_repo}")
    puts "clone #{url}.git from github"
    cd '../' do
      system "git clone #{url}.git #{local_repo}"
    end
  else
    cd "../#{local_repo}/" do
      puts "update #{url}"
      system "git reset --hard HEAD"
      system "git pull origin gh-pages"
    end
  end
end

desc "build jekyll site to dest"
task :build do
  dest = ENV["dest"] || local_repo
  puts "Build jekyll site to #{dest}"
  system "gulp compressed"
  system "bundle exec jekyll build -d #{dest} --config _config.yml,_production.yml"
end

desc "checkout gh-pages"
task :checkout do
  cd "../#{local_repo}/" do
    system "git checkout gh-pages"
  end
end

desc "push repo to github"
task :push do
  cd "../#{local_repo}/" do
    puts "add .nojekyll"
    system "touch .nojekyll"
    puts "Pushing to `gh-pages' branch:"
    system "git add -A"
    system "git commit -m 'update at #{Time.now.utc}'"
    system "git push origin gh-pages"
    puts "`gh-pages' branch updated."
  end
end

desc "deploy site to github"
task :deploy do
  repo = ENV["repo"] || remote_repo

  system "rake fetch_repo repo=#{repo}"
  system "rake checkout"
  system "rake build dest=../#{local_repo}"
  system "rake push"
  puts "has already deployed"
end

