deploy_site = "git@git.coding.net:gaogao"
local_repo = "jk.gaogao.ninja"
remote_repo = "JK-Uniform"
pages_branch = "coding-pages"

desc "fetch repo from deploy site"
task :fetch_repo do
  repo = ENV["repo"]
  #url= "git@github.com:gaogao1030/#{repo}"
  url= "#{deploy_site}/#{repo}"
  unless FileTest.directory?("../#{local_repo}")
    puts "clone #{url}.git from github"
    cd '../' do
      system "git clone #{url}.git #{local_repo}"
    end
  else
    cd "../#{local_repo}/" do
      puts "update #{url}"
      system "git reset --hard HEAD"
      system "git pull origin #{pages_branch}"
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

desc "checkout pages branch"
task :checkout do
  cd "../#{local_repo}/" do
    system "git checkout #{pages_branch}"
  end
end

desc "push repo to deploy site"
task :push do
  cd "../#{local_repo}/" do
    puts "add .nojekyll"
    system "touch .nojekyll"
    puts "Pushing to `#{pages_branch}' branch:"
    system "git add -A"
    system "git commit -m 'update at #{Time.now.utc}'"
    system "git push origin #{pages_branch}"
    puts "`#{pages_branch}' branch updated."
  end
end

desc "deploy site"
task :deploy do
  repo = ENV["repo"] || remote_repo

  system "rake fetch_repo repo=#{repo}"
  system "rake checkout"
  system "rake build dest=../#{local_repo}"
  system "rake push"
  puts "has already deployed"
end
