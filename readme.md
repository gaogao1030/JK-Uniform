#Readme
**该仓库的作用是为了避开github page 对jekyll插件的审核,其作用是让直接生成的静态页面显示**

* rake post(生成新的文章)

* rake draft(生成新的草稿)

* rake deploy(部署github page上的个人网站)


**GetStarted**
* npm install

* bundle install

* npm install gulp -g

* gem install compass

* 安装额外插件请用npm install *** --save-dev 将插件保存到package.json

* 使用gulp dev 进入开发模式(得益于browser-sync 不需再使用jekyll server了)

**配置**

* qiniu.yml 用来配置qiniu的key,secet,bucket

* qiniu_feth_data.yml 用来配置从七牛上抓取相册的数据

* _data/template下的模版数据是用来配置生成模版用的数据

* 有新的相册要添加的话请先上传到七牛然后配置上面这2个文件

**七牛抓取相册**

* rake fetch_all_cameraman_album

* rake fetch_all_jk_album

* rake fetch_cameraman_album name="name"

* rake fetch_jk_album name="name"

* name为抓取当前改摄影师或jk下的所有相册

**生成模版**

* rake generate_jk_template name="name" force="true"

* rake generate_cameraman_template name="name" force="true"

* rake generate_all_cameraman_template force="true"

* rake generate_all_jk_template force="true"

* name是jk或摄影师的名字 force为true的话 会强制生成模版 不管当前的模版是否存在 否则会跳过已经存在的模版 生成新的模版
