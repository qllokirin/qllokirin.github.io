---
title: Ubuntu&Windows&Android使用大杂烩
tags:
  - 重装
  - Ubuntu
categories:
  - 记录
description: '浅浅记录个人使用ubuntu所遇之事'
date: 6666-06-06 21:55:39
sticky: true
---

浅浅记录个人使用Ubuntu&Windows&Android所遇之事以及推荐的软件

<!-- more -->

什么，你说为什么没有**macos/ios**，当然是因为——我没有啦~

# Ubuntu

## ubuntu安装

安装的话大致流程就是

在Windows下分盘->制作启动盘->u盘启动安装->下一步下一步下一步（可能分盘会麻烦一点，但是可以只分一个/

推荐这个[教程](https://www.bilibili.com/video/BV1554y1n7zv)，感觉讲的比较细致

> 单Ubuntu分两个区 一个500MB的efi区 剩下的全部给`/`
>
> 双系统新装Ubuntu直接一个`/`
>
> 想扩容一下的，发现可压缩空间比空闲内存小的多，按照[这个](https://www.bilibili.com/video/BV12L4y1A72s)评论区置顶操作一下就好了

## WSL安装

> 先在`启用或关闭Windows功能`里面勾选`适用于Linux的Windows子系统`和`虚拟机平台`，重启

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

**安装完之后马上要做的事**

* **网卡**  检测网卡是否正常，如果可以直接开始上网，那就是非常的不戳

  有可能开机之后没有wifi选项，**解决办法**是：先连网线或者手机usb数据共享，换源然后`sudo apt update`和`sudo apt upgrade`，如果还是不行就去网上源码编译一下网卡驱动（去windows下面找到自己的网卡型号然后去搜一搜）就ok了

  但是不排除究极螃蟹网卡（对 我说的是mt7921 会时好时坏）最后我直接换了ax210

  又遇到一个逆天网卡AX101，Ubuntu22.04能有WiFi图标但有时能用有时不行，能用的时候带宽也只有50兆，感觉可能是网卡型号读错了然后不是很适配

  自己安装网卡驱动方法

  1. [Intel官网](https://www.intel.cn/content/www/cn/zh/support/articles/000005511/wireless.html)，确保内核版本大于要求版本，解压之后放入` /lib/firmware`即可
  2. 更新内核，[这里](https://wireless.wiki.kernel.org/en/users/Drivers/iwlwifi)可以看到Intel网卡与内核版本的关系   [内核图形化更新方法](https://zhuanlan.zhihu.com/p/686362507)

  AX211或AX201在[这里](http://archive.ubuntu.com/ubuntu/pool/universe/b/backport-iwlwifi-dkms/)下这个`backport-iwlwifi-dkms_9858-0ubuntu3_all.deb`，说实话很奇怪，不知道这个包是怎么来的干什么的

  ```
  wget https://archive.ubuntu.com/ubuntu/pool/universe/b/backport-iwlwifi-dkms/backport-iwlwifi-dkms_9858-0ubuntu3_all.deb
  sudo apt update
  sudo apt install ./backport-iwlwifi-dkms_9858-0ubuntu3_all.deb
  ```

  [rtl8852be](https://github.com/HRex39/rtl8852be)的安装依赖如下

  ```
  sudo apt-get update
  sudo apt-get install make gcc linux-headers-$(uname -r) build-essential git
  ```

  `lspci | grep -i net`找到形如`8086:51f1`的信息，输入到后面这个网址查询 [查看网卡型号](https://admin.pci-ids.ucw.cz/mods/PC/10de?action=help?help=pci)

* **换源**  选择一个国内源安装软件会更快，[Ubuntu清华源](https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/)，注意版本不要选错了

  然后打开一个终端<kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>T</kbd> ，输入`sudo apt update`和`sudo apt upgrade`更新源和更新软件

* ~~**显卡驱动**~~  (**很容易给ubunut安装到打不开，不熟可先跳过**)

  安装显卡驱动（如果有显卡的话），首选方法是在`软件更新`这个软件里面点一下安装，建议选择**sever版本**

  * 如果重启电脑正常启动，那恭喜你非常的顺利

  * 如果重启无法进入ubuntu，就在开机时候选第二个找一个恢复模式启动，再去`软件更新`里把显卡驱动卸载掉（点到最后一个就是卸载显卡驱动）

  * 如果还是要装显卡驱动可以去官网下载，有一些二选一需要做，可以参考[这篇文章](https://qii404.me/2021/07/03/ubuntu-install-nvidia-driver.html)，不过我的`X configuration`那个必须选no才能安装成功

    但如果安装之后还是**无法进入ubuntu**，则需要开机选第二个然后选第一个再选root进入命令行找到显卡驱动文件执行`./xxxxx  --uninstall`进行卸载

  > 拯救者之类需要在bios中单独设置独显直连模式

* **同步windows和Ubuntu时间**

  ```bash
  sudo apt install ntpdate
  sudo ntpdate time.windows.com
  sudo hwclock --localtime --systohc
  ```

  > 因为Ubuntu使用的是UTC机制，即把bios时间设置为格林尼治时间，显示时间时加八个小时
  > 而Windows的bios和显示保持一致，所以会差八小时

* **更改默认启动项（可选）**

  ```bash
  sudo gedit /etc/default/grub
  # 修改GRUB_DEFAULT=
  # 0代表第一个 windows一般在2
  sudo update-grub
  ```

## 实用工具

* **[谷歌搜索引擎](https://www.google.com/)**

  谷歌搜索引擎用多了只会觉得百度很垃（

  没有梯子时建议使用**必应**

* [**clion编译器**](https://www.jetbrains.com/clion/download/#section=linux)

  好用且配置方便，~~爆杀vscode~~（先选三十天试用，学生可以通过学信网认证免费使用

  `sudo snap install clion --classic`直接安装，然后输入`clion`运行即可

  > 如果是下载的压缩包，则需运行里面的clion.sh脚本
  >
  > 在.bashrc/.zshrc中写入`alias clion=xxx/bin/clion.sh` 之后就也可以输入clion命令打开了

* **输入法**

  首推还是搜狗，[官方教程](https://shurufa.sogou.com/linux/guide)，词库雀食是强大的  如果无法使用可以安装ibus的输出法，一定不会报错

  值得注意的是 如果你选的是英文界面（系统）设置的region& language界面中  manage install language上面要**只留下Chinese**才能使用搜狗 ，别问 问就是捯饬了半天才试出来

  Ubuntu22.04可以参照[这篇帖子](https://askubuntu.com/questions/1406597/how-to-get-sogou-pinyin-ime-work-properly-in-ubuntu-22-04)里面的做法

* **zsh**

  ```bash
  sudo apt install -y git zsh curl
  ```

  会提示切换到zsh终端，若没有切换成功可以输入chsh -s /bin/zsh后重启

  ```
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  ```

  自动补全插件

  ```
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  ```

  语法高亮

  ````
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```

  进`.zshrc`把73行的`plugins=(git)`改为

  ```
  plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
  ```

  主题agnoster简洁不用安装，直接修改`.zshrc`11行`ZSH_THEME`字段的即可

  ```
  ZSH_THEME="agnoster"
  ```

  输入`source ~/.zshrc`或重启终端即可生效

  若有字体乱码需要下载字体

  ```
  sudo apt-get install fonts-powerline
  ```

  主题powerlevel10k支持多种形式，可自行选择

  ```bash
  git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  ```

  ```text
  ZSH_THEME="powerlevel10k/powerlevel10k"
  ```

* **[conda](https://mirrors.bfsu.edu.cn/anaconda/archive/)**

  ```
  wget https://mirrors.bfsu.edu.cn/anaconda/archive/Anaconda3-2022.10-Linux-x86_64.sh
  ```
  
  没有过多需求的情况下，直接安装python也是一个很好的选择
  
* **typora**

  我发现[下载1.0](https://typora.io/releases/all)版本的也不会弹出收费推荐，舒服

  这还有篇文章给了[0.9版本](https://k0tk0t.github.io/2021/03/31/%E5%9C%A8Ubuntu%E4%B8%8A%E5%AE%89%E8%A3%85Typora/)的哈哈

  ```bash
  wget https://download.typora.io/linux/typora_1.0.3_amd64.deb
  ```

* **神——[docker](https://yeasy.gitbook.io/docker_practice/install/ubuntu)**

  安装docker

  ```
  # 如果curl不下来脚本，可以复制下来自己创建一个
  curl -fsSL get.docker.com -o get-docker.sh
  sudo sh get-docker.sh --mirror Aliyun
  ```

  换源

  ```
  sudo mkdir -p /etc/docker
  sudo tee /etc/docker/daemon.json <<EOF
  {
   "registry-mirrors": [
       "https://docker.1panel.live"
   ]
  }
  EOF
  sudo systemctl daemon-reload
  sudo systemctl restart docker
  ```

  安装docker-compose

  ```
  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  ```

* **命令行走代理**——[**proxychains**](https://m-ouse.github.io/post/proxychains%E9%85%8D%E7%BD%AE/)

* **录屏软件**——kamaz

  ```bash
  sudo apt install kazam
  ```

* **[ubuntu优化](https://blog.zzsqwq.cn/posts/141/)**

  战老师yyds！

  > 可以设置主题+图标+开机启动项背景+鼠标样式等
  >
  > 我用的是
  >
  > 应用程序 Orchis-Green-Light
  >
  > 光标 Nordic-cursors            
  >
  > 图标 Zafiro-icons-Light-Blue-f
  >
  > shell WhiteSur-light
  >
  > 开机启动选项 Hoshimati_Suisei_motify
  >
  > 然后自己魔改了张开机启动背景

  ![](images/%E5%BC%80%E6%9C%BA%E5%90%AF%E5%8A%A8%E7%94%BB%E9%9D%A2.png)

---

选择性安装软件

* **ros（不是**

  做机器人相关项目才会需要

  > 要不什么时候写个[教程](https://70lokirin.github.io/2022/10/17/ros/)？

* **[nomachine](https://downloads.nomachine.com/linux/?id=1)**

  远程桌面链接软件，配合3.5元的HDMI欺诈器能很好的图形化控制nuc等上位机

  > 记得选下面的x86/adm64即**64位**的软件，上面是32位

  **如果不是无网络局域网，感觉不如ToDesk或者向日葵或者UU远控**

* **[scp](https://blog.csdn.net/yaxuan88521/article/details/118481936)**

  对远端服务器直接进行复制粘贴

  ```zsh
  scp -r -P 316 ./xxx root@xx.xx.xx.xx:/home/xx
  ```

## 可能会遇到的问题

* **GitHub sshkey怎么生成都是鉴权失败**

  可能是端口问题：https://blog.csdn.net/alex_my/article/details/89336493

  > 若wifi有使用了软路由有代理或自己开了代理 部分机场会ban22端口（防ddos） 所以会鉴权失败

  ```bash
  gedit ~/.ssh/config
  # 填入如下内容
  Host github.com
  Hostname ssh.github.com
  Port 443
  ```

* **usb端口突然没有，比如/dev/video0（笔记本相机）端口没有了**

  进入bios关闭**Secure boot**即可

  > 虽然你可能会说你肯定之前关闭了，但你再看一眼，就会发现很神奇的是enable

* **ros拥有多个工作空间，在`.bashrc`中写了source但是没有用**

  source需要按照工作空间创建顺序进行source

  ~~在每一次source之后都加入--extend~~ **千万不要在后面加extend** 虽然source的时候是觉得方便了，但是你如果想通过取消掉这个source，可不只是简单的注释就行了



![_H_X_2_K~W_1O_0Q___1_1X.png](https://s2.loli.net/2023/01/28/k7SmWnJ3etpQiOV.png)

<div align="center">危</div>

一波简简单单的重装


![653a9e7181c31465875b376e1949932b.png](https://s2.loli.net/2023/01/29/EbYqw5DRXLVcpkl.png)

<div align="center">舒服了</div>

# Windows

## **日常软件**

| 名称                                                    | 说明                                               |
| ------------------------------------------------------- | -------------------------------------------------- |
| [QQ](https://im.qq.com/index/)                          | 其实自带的截屏很好用                               |
| [微信](https://weixin.qq.com/)                          | 有内测版支持暗色模式了                             |
| [网易云音乐](https://music.163.com/#/download)          | 可以自己下载音乐传到网易云盘然后就可以听没有的歌了 |
| [WPS](https://www.wps.cn/)                              | 文档自动云同步真的还可以                           |
| [谷歌浏览器](https://www.google.com/intl/zh-CN/chrome/) | 用谷歌账号同步所有数据，很爽                       |
| [BandZip](https://cn.bandisoft.com/bandizip/)           | 解压缩的神，b站可以找到破解版，不破解有广告        |

## **一点点技术软件**

| 名称                                                         | 说明                                       |
| ------------------------------------------------------------ | ------------------------------------------ |
| [mihomo-party](https://github.com/mihomo-party-org/mihomo-party/releases/latest) | 代理软件的新神，我评价为                   |
| [图吧工具箱](https://www.tbtool.cn/)                         | 无需多言 真正的神                          |
| [小丸工具箱](https://maruko.appinn.me/)                      | 压制视频的神                               |
| [格式工程](http://www.pcfreetime.com/formatfactory/cn/index.html) | 格式转换的神（不过好像说是违反了开源协议） |
| [everything](https://www.voidtools.com/zh-cn/downloads/)     | 搜索文件的神                               |
| [geek](https://geekuninstaller.com/download)                 | 卸载软件的神                               |
| [spacesniffer](https://github.com/redtrillix/SpaceSniffer/releases/latest) | 磁盘分析的神（方便清理硬盘）               |
| [potplayer](https://potplayer.daum.net/)                     | 视频播放的神                               |
| [DiskInternals Linux Reader](https://www.diskinternals.com/linux-reader/) | 查看ubuntu的文件                           |
| [BBdown](https://github.com/nilaoda/BBDown)                  | 命令行下载b站视频/音频的神                 |
| [唧唧Down](http://client.jijidown.com/)                      | 图形化下载b站视频/音频的神                 |
| [右键菜单管理](https://github.com/BluePointLilac/ContextMenuManager) | 非常好用                                   |
| [termius](https://termius.com/download/windows)              | ssh链接软件，学生认证后多端同步很好用      |

## **微软商店可下载**

| 名称            | 说明                      |
| --------------- | ------------------------- |
| TranslucentTB   | 底部栏透明                |
| Microsoft To Do | 做todolist 多端同步很好用 |

## **百度网盘不限速的神**

| 名称                     | 说明                           |
| ------------------------ | ------------------------------ |
| https://pan.f4team.cn/#/ | 需要进tg群获得动态密钥，无限制 |

## 其他

把windows powershell设置为预测历史指令自动补全

```powershell
# 以管理员身份打开powershell
# 允许运行脚本
set-executionpolicy remotesigned
# 寻找最新版本
Find-Module PSReadLine -AllVersions | Select-Object -First 5
# 我这里最新是2.3.6
Install-Module -Name PSReadLine -RequiredVersion 2.3.6
# 把预测源目设置成历史
Set-PSReadLineOption -PredictionSource History
# 重启powershell即可
```

第一次重启后可能存在psreadline模块无法加载的情况参考[这个](https://www.miyil.com/vue/940.html)

## 重装系统

重装系统钱需要保存的：

* **篡改猴/油猴脚本**，把安装的脚本存一下，重新安装后设置：扩展商店→篡改猴插件的详情→允许运行用户脚本→重启浏览器
* **git公钥私钥**，`C:\Users\<用户名>\.ssh`，xxx和xxx.pub，如果设置过密钥登录的话就保存一份

用**winget**安装上述基本软件和一些其他软件，`list.json`内容在下面

```powershell
# 以管理员身份打开powershell
# 如果winget没有，先安装
$progressPreference = 'silentlyContinue'
Write-Host "Installing WinGet PowerShell module from PSGallery..."
Install-PackageProvider -Name NuGet -Force | Out-Null
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
Repair-WinGetPackageManager -AllUsers
Write-Host "Done."
# 安装list.json里面的所有软件
winget import .\list.json --accept-package-agreements --accept-source-agreements
```

> 这样装有个缺点是有些软件不会创建快捷方式，比如SpaceSniffer、ContextMenuManager、geek
>
> [copyQ](https://github.com/hluk/CopyQ/releases/latest) 用安装包安装才可以添加开机自启动
>
> [VS Code](https://code.visualstudio.com/) 用安装包可以添加右键打开关联
>
> [wps](https://www.wps.cn/) 这玩意儿winget也能下但是特别特别慢
>
> [图吧工具箱](https://www.tbtool.cn/)
>
> [小丸工具箱](https://maruko.appinn.me/)
>
> [格式工程](http://www.pcfreetime.com/formatfactory/cn/index.html)
>
> [typora破解版](https://github.com/eglfiv/typora-activation)
>
> [Emby小秘版](https://t.me/sharereback/17)
>
> [oopz](https://oopz.cn/)
>
> [Microsoft To Do](https://go.microsoft.com/fwlink/?linkid=2135654)
>
> [VS stdio](https://visualstudio.microsoft.com/zh-hans/)
>
> 自行安装：MATLAB CUDA solidworks texlive

一些设置：

* `设置`->`系统`->`多任务处理`->可修改edge显示的窗口形式
* `右键桌面`->`个性化`->`主题`->`桌面图标设置`->可以把计算机弄出来
* `右键桌面`->`个性化`->`开始`->可以修改磁铁设置

```
{
	"$schema" : "https://aka.ms/winget-packages.schema.2.0.json",
	"CreationDate" : "2025-06-06T23:22:42.680-00:00",
	"Sources" : 
	[
		{
			"Packages" : 
			[
				{
					"PackageIdentifier" : "Tencent.QQ.NT"
				},
				{
					"PackageIdentifier" : "Tencent.WeChat.Universal"
				},
				{
					"PackageIdentifier" : "NetEase.CloudMusic"
				},
				{
					"PackageIdentifier" : "Google.Chrome.EXE"
				},
				{
					"PackageIdentifier" : "Bandisoft.Bandizip"
				},
				{
					"PackageIdentifier" : "Mihomo-Party.Mihomo-Party"
				},
				{
					"PackageIdentifier" : "voidtools.Everything"
				},
				{
					"PackageIdentifier" : "UderzoSoftware.SpaceSniffer"
				},
				{
					"PackageIdentifier" : "Daum.PotPlayer"
				},
				{
					"PackageIdentifier" : "BluePointLilac.ContextMenuManager"
				},
				{
					"PackageIdentifier" : "Termius.Termius"
				},
				{
					"PackageIdentifier" : "CharlesMilette.TranslucentTB"
				},
				{
					"PackageIdentifier" : "Bambulab.Bambustudio"
				},
				{
					"PackageIdentifier" : "Git.Git"
				},
				{
					"PackageIdentifier" : "Tencent.TencentMeeting"
				},
				{
					"PackageIdentifier" : "LocalSend.LocalSend"
				},
				{
					"PackageIdentifier" : "hluk.CopyQ"
				},
				{
					"PackageIdentifier" : "OpenJS.NodeJS.LTS"
				},
				{
					"PackageIdentifier" : "JetBrains.CLion"
				},
				{
					"PackageIdentifier" : "OBSProject.OBSStudio"
				},
				{
					"PackageIdentifier" : "Sogou.SogouInput"
				},
				{
					"PackageIdentifier" : "Valve.Steam"
				},
				{
					"PackageIdentifier" : "Reqable.Reqable"
				},
				{
					"PackageIdentifier" : "JLC.LCEDA.Pro"
				},
				{
					"PackageIdentifier" : "Baidu.BaiduNetdisk"
				},
				{
					"PackageIdentifier" : "agalwood.Motrix"
				},
				{
					"PackageIdentifier" : "PicGo.PicGo.Beta"
				},
				{
					"PackageIdentifier" : "ByteDance.Feishu"
				},
				{
					"PackageIdentifier" : "ByteDance.JianyingPro"
				},
				{
					"PackageIdentifier" : "Balena.Etcher"
				},
				{
					"PackageIdentifier" : "Telegram.TelegramDesktop"
				},
				{
					"PackageIdentifier" : "Python.Python.3.12"
				},
				{
					"PackageIdentifier" : "Microsoft.VisualStudioCode"
				},
				{
					"PackageIdentifier" : "Alibaba.QuarkCloudDrive"
				},
				{
					"PackageIdentifier" : "Microsoft.WindowsTerminal"
				},
				{
					"PackageIdentifier" : "NetEase.UURemote"
				},
				{
					"PackageIdentifier" : "GeekUninstaller.GeekUninstaller"
				}
			],
			"SourceDetails" : 
			{
				"Argument" : "https://mirrors.ustc.edu.cn/winget-source",
				"Identifier" : "Microsoft.Winget.Source_8wekyb3d8bbwe",
				"Name" : "winget",
				"Type" : "Microsoft.PreIndexed.Package"
			}
		}
	],
	"WinGetVersion" : "1.10.390"
}
```

# Android

## 日常软件

太多了，不放了

## 一点点科技软件

| 名称                                                         | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Clash Meta](https://github.com/MetaCubeX/ClashMetaForAndroid) | 持续更新，好用                                               |
| [Reex](https://www.52pojie.cn/thread-1814114-1-1.html)       | 跨平台视频播放器，在酷安可下载原版                           |
| [immich](https://github.com/immich-app/immich)               | 自建 NAS 相册，很强大，[教程](https://www.himiku.com/archives/immich.html)or[官方教程](https://immich.app/docs/install/docker-compose) |
| [MT管理器](https://mt2.cn/)                                  | 无需多言，平时用的最多的就是安装QQ发出来的.apk.1文件         |
| [ToDesk](https://www.todesk.com/download.html)               | 电脑开机自启动，偶尔要远程一下挺方便的                       |
| [Termius](https://termius.com/download/android)              | ssh链接软件，学生认证后多端同步很好用                        |
| [Termux](https://termux.dev/cn/)                             | 适用于 Android 的终端模拟器                                  |
| [Google Play 商店](https://play.google.com/store/games?hl=zh) | 下载软件很好用                                               |
| [李跳跳](https://github.com/rongzhiy/LiTiaotiao)             | 跳广告的神                                                   |
| [真实好友]((https://github.com/rongzhiy/LiTiaotiao))         | 检查微信单向好友                                             |
| [Stellarium](https://play.google.com/store/apps/details?id=com.noctuasoftware.stellarium_free) | 看星空的神                                                   |
| [LocalSend](https://localsend.org/zh-CN)                     | 局域网传文件的神                                             |
| [Google 地图](https://play.google.com/store/apps/details?id=com.google.android.apps.maps&hl=zh) | 看地理图很好用                                               |
| [Microsoft To Do](https://play.google.com/store/apps/details?id=com.microsoft.todos&hl=zh_TW) | 做todolist 多端同步很好用                                    |
| [WakeUp课程表](https://www.wakeup.fun/)                      | 看课表很好用                                                 |

## 网络监测软件

| 名称       | 说明                      |
| ---------- | ------------------------- |
| cellularZ  | 看信道干扰                |
| WiFi魔盒   | 功能很多                  |
| 全球网测   | 测网速，花瓣不支持a15目前 |
| Fing       | 查看局域网设备            |
| 网络百宝箱 | 功能很多                  |

## 我的搜索引擎解决方案

在谷歌商店下载Chrome Beta和Chrome两个谷歌，两个用不同的默认搜索引擎，然后摆两个搜索小组件放在桌面上即可

![image-20250321171916566](https://s2.loli.net/2025/03/21/IlDerEcHWzGPuns.png)
