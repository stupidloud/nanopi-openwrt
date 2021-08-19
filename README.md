# Nanopi R1S R2S R2C R4S Openwrt 固件

[刷机工具](https://www.balena.io/etcher/)  
[下载地址](#下载地址)  
[更新说明](#更新说明)  
[使用提示](#使用提示)  
[固件特性](#固件特性)  
[在线升级](#终端内在线升级方法)  
[1分钟生成自己所需固件](#1分钟生成自己所需固件)  

### 下载地址：
https://github.com/klever1988/nanopi-openwrt/releases  
(img.gz档不需要解压，可以直接使用刷机工具刷入)

### 使用提示：
默认用户名是root, 密码是password，局域网IP为192.168.2.1  
烧制完固件插入tf卡并启动完成，电脑端显示“网络（已连接）”之后，在浏览器输入 http://immortalwrt/ 可以直接打开路由器后台，无需修改本地连接设置或者查看IP地址。  
如果网络状态一直是未识别（上电超过5分钟），请直接插拔一次电源重启试试。

### 终端内在线升级方法：
```bash
wget -qO- https://github.com/klever1988/nanopi-openwrt/raw/master/scripts/autoupdate.sh | sh
```
slim版
```bash
wget -qO- https://github.com/klever1988/nanopi-openwrt/raw/master/scripts/autoupdate.sh | ver=-slim sh
```
(脚本由gary lau提供，非常感谢！)

### 固件特性：
- slim版固件只有OpenWrt本体，但内置了“本地软件源”，包含大部分常用插件，不喜欢固件预装繁杂插件的人可以选择这个版本，进入后台软件包选装所需插件
- 采用ext4文件系统，刷卡之后可自行使用分区工具对sd卡扩容根分区至最大
- 支持usb无线网卡（RTL8821CU芯片，例如COMFAST 811AC），可以驱动无线网卡运行在5G频段
- 使用[在线升级](#终端内在线升级方法)时，根分区会自动扩容，方便折腾

### 1分钟生成自己所需固件
因为本项目预编译了Image builder，生成固件仅需1-3分钟，如果有兴趣自定义固件可以Fork本项目，编辑设备对应的config.seed文件，例如r2s.config.seed, 去掉(整行删除)不需要的luci app软件包配置行，添加自己所需的软件，可用软件的列表可以在github actions构件输出处获取，例如  
<img src="https://user-images.githubusercontent.com/56048681/114531174-3beafb80-9c7e-11eb-8bcc-b098c3b1cee8.png" width="250" />  
<img src="https://user-images.githubusercontent.com/56048681/124495884-43d4ba80-ddeb-11eb-95e9-fb096dcfda45.png" width="250" />  
完成之后进入Actions，点击左侧Build，点击右侧Run workflow输入设备名（r2s/r2c/r4s/r1s/r1s-h3/r1p）  
<img src="https://user-images.githubusercontent.com/56048681/114531768-c7648c80-9c7e-11eb-8d72-fe38f9df960d.png" width="250" />  
再点击Run即可获取自己所需的固件

### 更新说明：
https://github.com/klever1988/nanopi-openwrt/blob/master/CHANGELOG.md

#### 本固件NAT基准性能测试：
<img src="https://raw.githubusercontent.com/klever1988/nanopi-openwrt/master/assets/NAT.jpg" width="450" />

#### 固件源码：
https://github.com/immortalwrt/immortalwrt
