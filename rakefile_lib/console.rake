desc "console"
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
  @qiniu_fetch_data = YAML::load_file('qiniu_fetch_data.yml')
  # 必须执行 ARGV.clear，不然 rake 后面的参数会被带到 IRB 里面
  ARGV.clear
  IRB.start
end
