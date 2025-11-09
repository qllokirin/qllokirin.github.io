---
title: 稀疏平常的生活
tags:
  - 日记
categories:
  - 生活
description: '我们所经历的日常..'
date: 7777-07-07 07:07:07
sticky: true
---

我们所经历的日常..

<!-- more -->

日记从上到下，从新到旧

# 2025

**十一月**

去外面干了十几天的活，终于回来了，天天上班的滋味，也不是很好啊，而且还要加班

又折腾了一下我的nx30pro路由器，因为老实无征兆死机，甚至插拔电源线也不一定能活过来，于是乎重刷了一下官方的Immortalwrt固件，但是预留的overlay分区很小，装不下我想要的nikki，折腾了很久扩分区，最后用的方法是自己编译固件把nikki打包进去，目前感觉良好，非常不错，自编译固件还挺好的，就是有一点点费时间，操作跟着README就行了

**十月**

[wsl-vscode](https://learn.microsoft.com/zh-cn/windows/wsl/tutorials/wsl-vscode)在Windows下使用wsl，打开vscode时使用wsl里面的Linux环境

**九月**

**[mihoro](https://github.com/spencerwooo/mihoro)**命令行运行代理，玩玩，若提示``GLIBC_2.33' not found`，在release中下载musl版本即可

> 感觉和直接用[mihomo](https://wiki.metacubex.one/startup/)也差不了太多

最近在逆向，过debugger检测可以看这位大佬的两篇魔改chromium的文章[1](https://zhuanlan.zhihu.com/p/1914040347912286987) [2](https://zhuanlan.zhihu.com/p/1914307835350717391)，不过不知道为什么我参考[官方教程](https://chromium.googlesource.com/chromium/src/+/main/docs/windows_build_instructions.md#Setting-up-Windows)编译出来的chromium运行特别的卡，最后用的这个项目的魔改[YSbrowser](https://github.com/selfshore/YSbrowser)，害怕隐私问题（不开源）所以给浏览器套了一个代理，只允许指定域名通过

路由器（nx30pro刷openwrt）最近总是不知名断连，需要插拔电源wifi才能回复，尝试过每天定时重启，没什么用，故怀疑是温度太高了，一看cpu71°，4.5元买了个usb风扇，往外抽50.4°，往里吹45.2°，但有一个问题，这风扇有点吵，噪音大。突然想起来之前做小冰箱也有风扇，把那个12V风扇强行接个5VUSB供电，这样噪音也小了，往外抽53.7°，往里吹51.6°，还可以，能接受

**八月**

重装了一手Windows

[GitHub学生认证](https://www.bilibili.com/video/BV1JrrmY1E4W)这块，真的幽默，最后是用记事本把信息写一写过的，原来是ocr吗，那无敌了

最近发现充电特别特别慢，用[充电功率计](https://jamcz.com/powerdumper/)一看才发现，竟然有时候会掉到0W，有时候百分之20的点也才10W，这显然不对劲，一番测试下来，是我后买的1.5m充电线出了问题，能正常调出快充100W，但充了几十秒之后就会掉功率，不过超级快充还是显示。我之前有一根线是冲上显示100W协议，然后一两秒之后快充表示就消失了哈哈哈，直接反手丢了

**七月**

阿里云送三百元代金券可以买半年云服务器，标称带宽300M（似乎经常有这样的活动），我一直在思考之前局域网搭建的各种服务应该怎么用，一个一个内网穿透出来实在是太麻烦了，而且公网的话域名没备份不让用，一个ip+端口实在是太丑了。于是我做了一计，在家里云上部署一个ssr代理，然后使用规则覆写加入到mihomo代理里面，规则也匹配一下，这样只要打开代理就能让我自己的网站正常访问了，原来什么配置都不用变

```
+proxies:
  - { name: SSR-内网穿透, type: ssr, server: x.x.x.x, port: 22222, password: xxxxxxxxxxxxx, cipher: chacha20-ietf, obfs: plain, protocol: auth_sha1_v4, protocol-param: "", obfs-param: "" }

+rules:
  - DOMAIN-SUFFIX,网站的域名,SSR-内网穿透
```

pid调参经验 
积分限幅可以慢慢加，直到能消除固差，应该要比这个值大
可以加入死区，但进入死区的那轮计算也要更新last error，否则从1.0进入死区，再从-1.0出死区，2的上次误差-这次误差会让d项有一个极大值
第一次计算的时候last error是0，要把这个赋成error
系统中有大跳变引发的震荡，把d调小反而能抑制震荡

**六月**

终于是把webdav挂载的番剧搭建了一个影音库，目前用的是emby，PC端使用**[embyToLocalPlayer](https://github.com/kjtsune/embyToLocalPlayer)**跳转使用potplayer进行播放，记得看FAQ→PotPlayer→提示渲染 Pin 失败，无法播放（原因是标题含空格或者个别半角符号，会导致 pot 无法从命令行启动，无法播放），手机端使用yamby，功能很强大

> PC端感觉也可以下载小秘版emby软件，使用比较爽（原版软件要米）

[winget](https://learn.microsoft.com/zh-cn/windows/package-manager/winget/)有点意思，感觉重装系统转软件的时候很有用，但是代理应该是必选项，镜像源似乎只是把url镜像了，安装包并没有镜像

```
winget export -o D:\list.json
winget import .\list.json --accept-package-agreements --accept-source-agreements
```

服务器的代理感觉还是不是很爽，docker clash感觉缺点还挺多，一是默认终端不代理，要设置环境变量，放.bashrc/.zshrc也算可以解决，二是有些代理不上，三是docker默认不代理、容器内代理不了，最近在试替代品

**五月**

pppoe重新拨号，不用重新输账号密码

```
pon dsl-provider
```

**四月**

最近在做毕设，学习了一下嘉立创eda，看的这个[教程](https://www.bilibili.com/video/BV1At421h7Ui/)，感觉非常的不错

```
q-切换单位
Ctrl shift x-布局传递
b-切换到底层（走线时按b为打过孔）
t-切换到顶层
shift B-铺铜重建
```

**[chrome-QuickGo](https://github.com/Dolov/chrome-QuickGo)**

今天装了个wsl2，说实话，感觉还挺不错的

> 现在`启用或关闭Windows功能`里面勾选`适用于Linux的Windows子系统`和`虚拟机平台`，重启
>

```powershell
# 更新wsl
wsl --update
# 查看可安装的镜像 如果提示需要升级就升级一下
wsl --list --online
# 安装Ubuntu20.04
wsl --install Ubuntu-20.04
# 查看目前有哪些已经下载的
wsl --list -v
# 启动
wsl -d Ubuntu-20.04
# 关机
wsl --shutdown
# 删除
wsl --unregister Ubuntu
```

wsl使用gazebo卡顿可以参考https://www.bilibili.com/read/cv6266330把`C:\Program Files\WSL`里面的exe都放进去选择高性能

说起来也巧，妈妈的红米经常自动无限重启，可能是经典电源键问题或者cpu虚焊，故说是给妈妈新买一个，但是妈觉得太贵没必要就一直不去线下店试试小屏机习不习惯，就当我准备直接买的时候，妈的手机直接屏幕摔坏了，是好消息也是坏消息哈哈哈，成功去试了一下线下店，直接给妈买了个oppo findx8s+（其实我是想买一加13的，但是我妈之前做过电信营业厅的销售，显然是不知道一加的，所以觉得不是大品牌，故还是买ov吧）

然后再画75r给摔碎的红米买个答辩lcd屏，轻松换好，方便把数据转出来，不过后盖被我拆碎了哈哈哈，问题不太大

一次取快递的时候，我找了老半天都没找见，按着序号找，比我小的 比我大的都找到，但是没有我的，我也想过会不会掉到货架后面去了，我也找了找，后面让工作人员帮我找，找了一小会儿，才发现是掉到货架前面了（

又一次取快递的时候，发现地上有一个快递，一看序号应该是货架中层的，我便放进了他本来应该处在的大概位置，顺手的事~

**三月**

qBittorrent/alist正则表达式重命名番剧通用

```
.*?\[(\d{2})\].*?\.mkv$
番剧名称 S01E$1.mkv
```

windows powershell重命名

```
# 批量重命名.ass文件，从 {数字} 格式改为E{数字}格式，如果数字被括号或者中括号包围，要加\( \) \[ \]
Get-ChildItem -Filter "*.ass" |
Where-Object { $_.Name -match '.*?(\d+).*?\.ass$' } |
Rename-Item -NewName { "灼眼的夏娜 III -Final- E$("{0:D2}" -f [int]$matches[1]).ass" } -Verbose
```

搭建了NAS相册，使用的是[immich](https://github.com/immich-app/immich)，[这篇教程](https://www.himiku.com/archives/immich.html)很详细

关于`机器学习的`这块的设置还是有点坑的

第一个是默认URL是`http://immich_machine_learning:3003`，如果你使用的是官方教程**请勿修改这个URL**，因为immich_machine_learning其实是容器名，让immich_sever找immich_machine_learning容器的3003端口，没问题。我一直以为是什么下载模型的网站什么的，整了半天

如果要修改默认模型下载网站可以在`.env`中添加`HF_ENDPOINT=https://hf-mirror.com`，这样不设置代理也可以成功下载模型，可以为后面剩下一步坑。

如果不修改模型下载网站就需要给docker设置代理或者下载好模型放进去，设置代理我使用的是这样的办法

```
services:
…………………………………………
  immich-machine-learning:
…………………………………………
    volumes:
      - ./model-cache:/cache
    networks:
      - clash_clash-network
    environment:
      - http_proxy=http://172.28.0.10:7890
      - https_proxy=http://172.28.0.10:7890
      - no_proxy=localhost,127.0.0.1,.mycompany.local
…………………………………………
networks:
  clash_clash-network:
    external: true
```

clash docker

```
services:
  clash-client:
    image: dreamacro/clash
    container_name: clash-client
    restart: always
    ports:
      - "127.0.0.1:7890:7890"  # 转发本地 7890 端口到容器的 7890 端口
      - "127.0.0.1:9090:9090"  # 转发本地 9090 端口到容器的 9090 端口
    volumes:
      - ./xfltd.yaml:/root/.config/clash/config.yaml
      - ./ui:/ui
    networks:
      clash-network:
        ipv4_address: 172.28.0.10  # 设置固定 IP 地址

networks:
  clash-network:
    driver: bridge  # 使用 bridge 网络驱动
    ipam:
      driver: default
      config:
        - subnet: "172.28.0.0/16"  # 定义子网范围
```

但是这样还要改配置，有点麻烦，所以直接在命令行下载好是个不错的选择。这里可以看到`immich-machine-learning`容器的挂载是`model-cache:/cache`，所以需要将模型放入当前路径下的model-cache中，问题就在到底应该是怎么样的路径结构，这个我弄了很久（其实还有很大一部分原因是我刚开始把URL改了，导致我这个无论怎么改都都不会正常运行hhh）我使用的是官方教程，model-cache中结构目录如下即可

```
.
├── clip
│   └── XLM-Roberta-Large-Vit-B-16Plus
└── facial-recognition
    └── antelopev2
```

可以通过`docker logs`查看容器的报错

[immich上传库中删除本地照片后前台页面仍显示照片的问题解决方法](https://blog.csdn.net/sinat_36164818/article/details/139755591)

**二月**

nplayer 字体重建非常难受 pass了，目前在用reex看之前alist挂载的番剧

[Rclone挂载WebDav为本地磁盘](https://wgxls.site/posts/rclone-mount-webdav/) 开机自启动[参考](https://www.bilibili.com/opus/924962456114036736)

> 设置开机自启动但是无法挂载的时候可能会出现，删除一个文件需要刷新才能显示，建议注释掉脚本让其不生效。等可以挂载后再启用

openwrt Nikki 和 mihomo有时候规则集可能会更新失败，需要自己删掉rule之后再次更新

```
openwrt:/etc/nikki/run/ruleset
windows:C:\Users\qllokirin\AppData\Roaming\mihomo-party\work\ruleset
```

**一月**

https://iriun.com/ 手机摄像头变成电脑摄像头

1p可以申请通配证书，好用

[vitepress](https://vitepress.dev/zh/)写文档挺好看的  [别人的教程](https://docs.bugdesigner.cn/docs/Tutorial/vitepress.html)

# 2024

**一月**

把windows powershell设置为预测历史指令自动补全

```powershell
#寻找最新版本
Find-Module PSReadLine -AllVersions | Select-Object -First 5
#我这里最新是2.3.6
Install-Module -Name PSReadLine -RequiredVersion 2.3.6
#把预测源目设置成历史
Set-PSReadLineOption -PredictionSource History
#重启powershell即可
```

第一次重启后可能存在psreadline模块无法加载的情况参考[这个](https://www.miyil.com/vue/940.html)

**二月**

跟朋友试试这个仓库 https://github.com/LC044/WeChatMsg

~~感觉挺有意思~~

**三月**

[网盘不限速](https://greasyfork.org/zh-CN/scripts/472925)，不过已经不维护了，估计快失效了

> 2024.6 [这个](http://1.94.138.197/bangumi)好用，满速下载

**四月**

~~真不想学专业课了，想摆了（~~

> 好耶 现在都结束了

**五月**

最涨教训的一天，<u>五月一号</u>

`win+r`输入`shell:startup`，创建`mount_nfs.bat`，写入`net use Z: \\{smb服务器地址}\{共享文件夹名称} /user:{用户名} {密码} `，这样挂载共享文件夹不会自动创建`system volume information`这个恶心人的文件夹

我自己买了个域名解析到`10.xx`的保留地址（学校内网）上了，一般的clash规则会这么写`\- IP-CIDR,10.0.0.0/8,🎯 全球直连`，所以我的域名相关网站不会解析为代理，但是用的订阅转换规则一般喜欢用`\- IP-CIDR,10.0.0.0/8,🎯 全球直连,no-resolve`，no-resolve也就是不解析域名，所以我的域名没有被解析出来，他也就不知道这是一个`10.xx`的内网地址。加这个字段的目的应该是为了防止一些域名污染，解析到内网地址从而代理不了，但很困扰我，不过我找到一个解决办法：`配置`->`右键自己的代理`->`配置文件预处理`加上下面的字段，每次更新订阅是会自动追加规则

```
parsers:
  - url: {你的订阅链接}
    yaml:
      # 代表在原规则前面追加规则
      prepend-rules:
        # 以jetbrains.com结尾的请求都走DIRECT [也可以填你的策略组名]
        - DOMAIN-SUFFIX,jetbrains.com,DIRECT  
```

potplayer竟然可以打开摄像头，主要是可以很方便的查看usb摄像头支持的最大画面，爽！`打开 - >设备设置 - >摄像头`

**六月**

我是不是早已与往日不同了呢

**七月**

[阿里docker镜像](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors) 神！

> 感觉不如[1panel](https://1panel.cn/docs/user_manual/containers/setting/)一根
>
> ```
> sudo mkdir -p /etc/docker
> sudo tee /etc/docker/daemon.json <<EOF
> {
> "registry-mirrors": [
>   "https://docker.1panel.live"
> ]
> }
> EOF
> sudo systemctl daemon-reload
> sudo systemctl restart docker
> ```
>
> 感觉不如[毫秒镜像](https://1ms.run/)一根
>
> ```
> echo '{"registry-mirrors":["https://docker.1ms.run"],"dns": ["8.8.8.8", "114.114.114.114"]}' | sudo tee /etc/docker/daemon.json > /dev/null
> sudo systemctl daemon-reload
> sudo systemctl restart docker
> ```
>
> 设置docker代理
>
> ```
> sudo mkdir -p /etc/systemd/system/docker.service.d
> sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf
> ```
>
> ```
> [Service]
> Environment="HTTP_PROXY=http://127.0.0.1:7890"
> Environment="HTTPS_PROXY=http://127.0.0.1:7890"
> ```
>
> ```
> sudo systemctl daemon-reload
> sudo systemctl restart docker
> ```

用qt写cmake项目时经常会出现改了ui但是编译运行的时候还是没变，只需要找一个cpp打一个空格然后不保存编译就行了（让他自动保存）

**八月**

最难受的一集，给nuc装系统的时候，硬盘没有初始化，直接选了erase and install，结果给我启动盘擦了，g

[Clonezilla再生龙](https://blog.csdn.net/wf19930209/article/details/100012611)，硬盘对拷/硬盘打包镜像，最好用的一集，250g ubuntu，两分钟拷贝完成，我猜是自动摒弃了空余空间

[ubuntu 串口别名](https://blog.csdn.net/weixin_56641176/article/details/130912273)，雀食好用

typora+smms图床设置，第一 设置下代理服务器，网页能上传但是api不一定行，第二 相同图片不能上传会报错（即使名字不同），测试的时候多整几张图

**九月**

[沉浸式翻译](https://immersivetranslate.com/zh-Hans/)最好用的一集，秒杀谷歌翻译

洛天依全息演唱会 爽！

**十月**

抓包的时候发现要开启[这个](https://blog.csdn.net/zy_281870667/article/details/89788640)，可以抓到重定向之前的URL，模拟请求的时候也要请求重定向之前的URL，否则会鉴权失败

14889+5696

`termux`配置python环境跑个小程序

```
# 换源
termux-change-repo
pkg update
pkg install python3
# 不安装openssl pip装东西的时候会报错
pkg install openssl
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install requests
```

[2024跑步打卡教程](https://www.123684.com/s/CVqajv-jYVWd)

**十一月**

最近遇到一个有意思的连锁反应，N100小主机无法使用ToDesk远屏幕操控→研究其他远程控制方式→发现有个叫moonlight和sunlight的可以低延迟串流→解锁新姿势-在床上玩电脑steam游戏→但是局域网才可以，学校网皎月连直接打不通→研究ipv6→宿舍的TPLINK路由器无法关闭ipv6防火墙→想买个小米路由器，既可以直接关闭ipv6防火墙又可以刷op，还可以双wan聚合，网速翻倍，爽！

但是转念一想会发现这一切没什么用，首先小主机根本没有远程控制屏幕的需求，全用命令行就行了，而且买路由器不能解决n100无法远程屏幕控制的问题，其次买新路由器的话是可以随时随地ipv6串流了，但问题是，为什么不用更加方便的ToDesk呢，哈哈哈，放弃了，还是等会儿去研究下n100为什么不行然后换一个方法远程操控。

研究了半天最后在UPnP里面发现有一台别人的电脑把sunshine默认端口已经在转发使用了，所以我设置的端口转发一直生效不了，（不过话说也挺神奇的，竟然能越过路由器的设置自动打通端口）然后我把我的sunshine换了一个端口就解决了，折腾，爽！

https://account.jetbrains.com/licenses的`Renew my Education Pack`

[Google风格C++编程规范](https://zh-google-styleguide.readthedocs.io/en/latest/google-cpp-styleguide/naming.html)

```
小写下划线：变量名 文件名 函数 命名空间
大驼峰：类名 结构体
类数据成员后面带一个下划线，结构体和普通变量后面不接下划线
常量以k开头 如kEnumName
宏如 MY_MACRO_THAT_SCARES_SMALL_CHILDREN
枚举与常量一致
```

**十二月**

代理软件切换为 [mihomo-party](https://github.com/mihomo-party-org/mihomo-party)  和  [ClashMetaForAndroid](https://github.com/MetaCubeX/ClashMetaForAndroid)，感觉是真好用

[晨钟酱](https://jamcz.com/)的搞机工具箱和投屏控制器有点意思

[Auto_Bangumi](https://github.com/EstrellaXD/Auto_Bangumi)订阅番剧、Alis挂载磁盘、potplayer添加专辑用webdav播放、手机用Nplayer播放

原来docker之间是互通的，看了ip之后就可以在a容器里面设置b容器的端口为代理了

在 `ssh` 命令中，使用 `-p` 来指定端口；在 `scp` 或 `sftp` 命令中，使用 `-P` 来指定端口

密钥登录：客户端使用`ssh-keygen -o`生成密钥，`cat ~/.ssh/id_rsa.pub`查看公钥，放入服务器中的`~/.ssh/authorized_keys`，一行一个；`sudo vim /etc/ssh/sshd_config`修改配置

> 一定注意是sshd不是ssh，害我浪费半天

```
#禁用密码验证
PasswordAuthentication no
#启用密钥验证
PubkeyAuthentication yes
#重启ssh服务
sudo service ssh restart
```


# 2023

**一月**

* 做了件任性的事，不知道有没有伤害到你们呢

  > 笑死 自己再看此句依然忘了干了什么了

**二月**

* 记录下来往花费时间，方便后面查

  学校校车.老校区——新校区：1h

  学校的车:新校区——机场：1h多一点

  拼车.机场——新校区（50rmb）：

  拼车.仁村——新校区（10rmb）：30mins

  新校区——西安国际医学中心：都是黑车司机，谨慎

  地铁+拼车/公交：机场——新校区：3h往上

* 双笙幻彩国巡演.西安站，一次美好的还愿

* 到校第一天，没找到我的自行车，以为是天太黑了没看到，就准备第二天找

  第二天还愿去了

  第三天把我经常停的那个地方转了又转也没见着

  第四天找了找周边的几个宿舍门口也是无果，看见好多自行车都锁了，但我的车是一直没锁，有一丝这样的念头：“学校都是坏人www 再也不停外面了 再也不要不锁车了”，不过再转念想想，第一那没锁的车也挺多，为什么是我，第二我的车应该是那里面比较烂的，还有这么多好车，为什么是我，想来想去再学校里被偷车还是有点奇怪

  第五天还在找，感觉没希望了，都快准备放弃了，见着一只不知名的鸟，而且还飞的离我很近，我当时突然想到了《久保同学》里面的剧情，“今天见到了白石同学，运气会很好”，那我今天见到了这只鸟，运气会变好吗 会找到我的车吗，我又多多看了它几眼，期盼着会有好事发生

  的确，我在食堂门口附近找到了我的车，锁车？不可能的
  
* 你就像星子，洒落在我梦里

* [啥都不想做](https://www.bilibili.com/video/BV1GM411i7is) 

* 再不学开学考试就要g了www 快学 学不完了

* 弄了下评论区，参考链接

  https://vuepress-theme-hope.github.io/v2/comment/zh/guide/giscus.html
  
* 弄了下windows美化

  微软自带磁铁 但是只有图片 点了没效果 有点弱

  https://apps.microsoft.com/store/detail/tile-genie/9WZDNCRFJ215?hl=en-us&gl=us

  `使用全屏开始屏幕` 个性化->开始

  某位up自制磁铁，可以把软件改磁铁背景

  https://www.bilibili.com/video/BV1t741187nz/?spm_id_from=333.999.0.0
  
  ![image.png](https://s2.loli.net/2023/03/02/bDm7O2nWCr3UZQo.png)

**三月**

*  大二下，绩点排名专业百分之五十，有点迷茫，周围都是百分之十百分之五或者是专业前几的稳定保研人，学长劝我再好好学，还有机会，不过考虑到我语文和英语的薄弱基础，感觉希望很微妙，聊着聊着一个双非学化学的哥们说自己还挂科了，你酒吧舞还emo。我们到时候应是都会找到自己的工作开始赚钱的吧，如果是那样的话，忧虑或许能降低一点，心中总想着，一切都会过去的

  > 奋斗了一年，竟然保上研，回望真是感叹啊
  
* 也曾想成为“特别”的人，不过思来想去学到现在，所学的东西当然不够特别，总有学的更好更多的在身边，不过之前萌生了做个视频的想法，思路和构思感觉有了，不知道做完之后，能否对“特别”有再深层一次的理解呢

**五月**

* 7295+6678+2429

**六月**

* github学生认证：录取通知书+一卡通+小纸条写github name

**十二月**

* 太神奇了，[`QQ邮箱不行 其他邮箱 使用 smtp 加密端口号 465`](https://developer.aliyun.com/ask/104139)      [`由于阿里云禁用了25端口所以替换成465端口并修改协议为ssl才能发送邮件`](https://blog.csdn.net/u013412790/article/details/72904038)   

  最近是用的一个[自动监测成绩脚本](https://github.com/cheanus/Automation/blob/main/GradesMonitorLinux)，里面发送邮件相关的函数是`smtp_obj.connect('smtp.qq.com', 25)`，使用的是25端口，阿里云把它给封了，用`telnet smtp.qq.com 25`无法连通，但是`telnet smtp.qq.com 465`是可以的，换了几次关键词上面两个相似的博客，最终还是问的GPT【**smtp_obj.connect('smtp.qq.com', 25)修改为使用465端口 并 修改协议为ssl**】直接成功拿下，用如下代码即可

  ```
  smtp_obj = smtplib.SMTP_SSL(mail_host, mail_port)
  ```

  > 转眼六个月没更新日记了，哈哈 发生了什么呢

* 
  予我黑夜

  远方 忽有孤灯闪烁

* 本想定位飞机忽然下坠的问题（可能是pid的问题，飞控或者代码

  但是有个桨突然不转了 g（经典复刻

  > 似乎是分电板接触不良

  补充：原因是电机动力不足，飞机太重

* **就像** 一周以后要考试，但学校不让你复习，旁边的人也不让你复习，非常的难受（不过测了一些内容 含可以，以后要去外面飞了

* 重构代码是什么人间趣(qv)事(shi)，改了十几个文件，最终效果不会有变化，只是改了代码，每次提交都害怕下次飞机就炸机了（）

* 数据集重标重训，yolo效果真好啊

  > 非常奇怪的是学长学姐说之前的权重文件效果也很好来着，不知道为什么我运行起来就基本不识别，感觉是哪里没弄好

  补充：原因是场地发生了变化，光线不一样了

* 此网站在谷歌中能被搜索到

  > 教程：[让Google搜索到自己的博客](https://zoharandroid.github.io/2019-08-03-%E8%AE%A9%E8%B0%B7%E6%AD%8C%E6%90%9C%E7%B4%A2%E5%88%B0%E8%87%AA%E5%B7%B1%E7%9A%84%E5%8D%9A%E5%AE%A2/)
  >
  > [必应搜索](https://www.bing.com/webmasters/about) 可以在谷歌配置好之后一键导入bing 使用谷歌账号登陆即可
  >
  > ~~[百度同理](https://ziyuan.baidu.com/https/index)~~ 百度这个 验证成功但是我搜不到 奇怪

* 解决ubuntu显卡驱动问题 www [bwyyds](https://www.tomcatdeng.cn/)

  > 顺便也能用会本来的桌面系统和搜狗输入法了 好耶！

* 有场地了 开心

* 每周固定十几个小时，节假日基本都要集训（比如国庆有时候只有一两天时间是放假），寒暑假也有一个月以上集训。听说有人还说我们基地水是真的没绷住

  > 我天天没有课就跑过来调飞机，周内有时间就在想怎么改进，到时候得奖  有人说奖很水的话我是真怕我会跟他急
  >
  > **不管了 先做好自己能做的吧**  ——  这也是我一般情况下的想法

* 硬盘复活~~ 原来是里面接触不良 拆开之后插拔一下就好了

* 剪头发的时候真的是极致的享受，不过就是学校剪的时间没有老家那边长（

* 飞机备赛进度90％  总算是大致可行了

* 有些迷茫，很多课程都落下了很多了

**十一月**

* 老爸被骗子骗了很多钱，伤心 难过 亦或是 后悔

  或许我爸也曾经有个清华梦吧

  思考了下午最终我意识到我们还是活在现在的人：

  **过去的事情已然过去，后悔便是毫无意义**

  “不要紧，我没事，就当输了一场牌吧！”

  **糊涂**总是贯穿人生  我亦如此

* 今天突然想起来大一室友给我说：“你这放的啥歌”

  我本来以为是真的想知道是啥歌，后来想了想，应该是提醒我不要外放

  类似这样委婉的提醒我真的很难注意到，比起这样我更希望你直接给我说，“不要外放可以吗”

  > 大四了，或许室友也不介意当时放的歌其实

* RoboCup中国机器人大赛-无人机挑战赛-快递识别赛 结束！

  第一名拿下！！不负从七月底就开始备赛的我们

  每周都在准备，周内有时间也过去调飞机

  这个周末异常的充实，两天过去以为都已经一周了哈哈

* [欢太云服务](https://cloud.heytap.com/login.html)yyds！！

  今天手机丢到草地里面了，用环太云服务找回了，太爽了

  建议大家都在自己手机里面找找有无找回手机的功能，开启一下

* 我的字好丑，一个人的字怎么可以这么丑呐

  呐呐呐呐呐呐呐呐呐呐

**十二月**

* 今天开了足基招新宣讲，我也稍微思索了下我们应该需要怎样的人

  * 编程能力：会基本的语法我觉得大抵是够了，最好会类的写法，不会也没关系，因为我入队的时候也不会

    ~~你敢相信搓了3k行策略代码拿了国一的人到现在还没弄清楚cin和cout后面的尖角朝向~~，我刚进基地的时候只会c语言，水平也是会几个循环和判断，学了下sdl库做了个小游戏（不过我很极限，据说因为分数不够是要被刷掉的，但是有位学长把我硬捞起来了，阿里嘎多）

    主要这个东西后面是可以从不会到会的  没有问题

    > 过了一年再看这个问题，我还是希望进来的一个是已经会c++ 类 stl 或者 python的，从一开始就有代码能力的话，还是会好很多
    >
    > 又过了一年，或许代码能力也没那么重要，有点基础后面来了再学就可以了

  * 沟通能力：我觉得只是至关重要的东西，他不是指能不能把话说清楚，而是包含与人说话时给人的感受以及更多，这或许说的是  温良，怪才或许不是很需要

  * 去与不去能力：（暂且这么叫吧）评判这个值的高低是这么一回事，就是有一件事，大家都能做而且这件事是需要有人弄的但是又没有明确的职责确定，在有时候没用负责人时，这个东西就很重要

    异或是你对于一件需要有人去帮忙但不一定是你去的事，去做的意愿值有多大

    > “那必须是我了！”
    >
    > “总会有人去的.”

  * 你问对机器人的热爱程度？老实说，我倒希望这方面意愿能低一些，如果你怀着极大的热爱进来之后发现做着与当初所想相去甚远的事，学长学姐也不好受，你也不好受。有一种对机器人的好奇心感觉就足够了，进来之后会逐渐喜欢上的

    比如说我，进基地之前都挺无感的，因为根本不清楚那到底是个什么玩意儿。到现在，我甚至想自己花钱组一架无人机了（在构思了在构思了 真组出来一定水一篇新文章然后拍视频  ~~超想上颜料然后刻一个洛洛~~

* 最近听了星尘感觉也好好听！

  两首良曲

  [无语咯【星尘infinity原创曲】](https://www.bilibili.com/video/BV1oG4y1674W/)

  [我多想说再见啊【星尘Infinity】[原创曲]](https://www.bilibili.com/video/BV1dP4y1T7TU)

  这么说来我最初知道v家还是[绮云泽](https://www.bilibili.com/video/BV1Bb411c7v2)这首歌（从人本那来的），v本也是星尘，后面慢慢入了天依（洛洛超可爱！）的坑，每天在v家里面挖良曲真开心，有很多有意思的创作者，或是超可爱的pv，或是让人会心一笑的词作，或是旋律恰到好处的作曲，又或是 超强的一体机p主

  总之，入了此坑很开心

* 感觉主题有点花，不是很适合写东西

  换了一个，感觉还不错

* 层云尽染，漫想雪中踱步

  ![5UNDVVMR_1E8TBQ__FSD2_X.jpg](https://s2.loli.net/2022/12/17/AGzoInhDa8FElNe.jpg)

  ![WVW_G697FL2__QHE6_P_QWM.jpg](https://s2.loli.net/2022/12/17/f8yjSmDGoNAC6tW.jpg)

* 今天终于解决了蓝牙的问题 好耶！！

  之前一直有个情况是：连了蓝牙会有两个设备

  Stereo音质好但是一和xdm打游戏连麦就游戏没有声音了

  AG Audio能连麦打游戏但是音质烂的爆炸

  ![1.png](https://s2.loli.net/2022/12/17/wGW4KmTEd6M2hDy.png)

  今天想着要解决一下就搜了搜，最后试了试重装一下驱动就好了！

  我是自己换了一个ax210的网卡，[wifi驱动](https://www.intel.cn/content/www/cn/zh/download/19351/windows-10-and-windows-11-wi-fi-drivers-for-intel-wireless-adapters.html)   [蓝牙驱动](https://www.intel.cn/content/www/cn/zh/download/18649/intel-wireless-bluetooth-for-windows-10-and-windows-11.html)

* 发现个好东西，对于喜欢截屏的太友好了，之前一直以为QQ截图是神中神，今天发现snipaste这个软件也挺有优势的，在Microsoft商店就能下（挂个梯子下起来快一点）教程：https://docs.snipaste.com/zh-cn/

  功能只能用强大二字来形容，不过没有文字识别和长截屏，但QQ截屏有

  > 不过以后面使用经验来说，习惯了QQ截屏很少记得起还有这个东西

* 今天看了一个[Linux教程](https://www.runoob.com/linux/linux-tutorial.html)，介绍了很多常用的东西，了解的更明白了

  * **关于`./`**

    比如可以`./test.sh`，我就一直以为./是运行某个文件的意思，看了文章才知道./是指定当前路径，`./test.sh`就是指定到当前路径下的名叫test.sh的文件，而解释器在文件中第一行指定了，如`#!/bin/bash`，所以也可以像这样运行`/bin/bash test.sh`，而直接输`test.sh`会去`/usr/bin`那种路径下去找，显然是找不到的

  * **ssh链接的简便方法**

    [**Xshell**和**xftp**](https://www.xshell.com/zh/free-for-home-school/)图形化 yyds，主要是可以记住ip，端口，密码 下次登陆不需要再输，很方便

    > Xshell老弹广告，我现在在用[mobaxterm](https://mobaxterm.mobatek.net/)，还可以拖拽传文件，好用

  >> 现在转用[Termius](https://termius.com/)，github学生认证之后使用，三端自动同步，非常好用

    Linux下有一个类似的软件 [finalshell](http://www.hostbuf.com/t/1059.html)(这个官网简陋到我以为是什么论坛之类的 误)

  * **关机开机的指令**

    `shutdown`：关机

    `shutdown -h 20:25`：今天20:25关机

    `shutdown -h +10`：十分钟后关机

    `shutdown -r `：重启 同`reboot`

  * 其实关于文件基本属性的介绍也很细致，以前只了解几个指令，但不明白具体是什么意思

    几个常用指令介绍也很清楚

  * `df -h`：查看磁盘大小和剩余

    `ll`：查看文件详细信息  `ll /usr/bin/python*`查看所有python软连接指向

    `ls -hl`：查看当前路径下的文件大小，文件夹显示为4k

    `du -h --max-depth=1`：查看当前文件和文件夹大小

# 2022

**九月**

* 百（社）团大战有马儿跳wwwww

  可我在旁边调飞机  悲

* 烧了一个小时程序最后发现是板子有问题

* 足基蛋糕 好耶

**十月**

* 规划器.局部规划&全局规划调试（穿啊 你快穿过去啊  （急了

- [x] 飞机穿门

* 解决了历史性的视觉识别**延迟**问题

  虽然队列长度设置为1并没有按照我们所想的那样进行读取发送

  但是把相机输入由30帧变为10帧就好了（？）

* 光鲜亮丽的世界