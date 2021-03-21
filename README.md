# Nanopi R1S R2S R4S Openwrt 固件

[刷机工具](https://www.balena.io/etcher/)  
[下载地址](#下载地址)  
[更新说明](#更新说明)  
[使用提示](#使用提示)  
[固件特性](#固件特性)  
[在线升级](#终端内在线升级方法)  

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

### 更新说明：
https://github.com/klever1988/nanopi-openwrt/blob/master/CHANGELOG.md

#### 本固件NAT基准性能测试：
<img src="https://raw.githubusercontent.com/klever1988/nanopi-openwrt/master/assets/NAT.jpg" width="450" />

#### 固件源码：
https://github.com/immortalwrt/immortalwrt
