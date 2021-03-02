## Nanopi r1s r2s openwrt 固件自动编译

### 临时说明：
暂时不要fork自己编译，因为编译缓存因为github actions工作路径不同，是无效的，会导致你的编译时间非常长。我正在生成统一路径的编译缓存，并且修改脚本统一fork之后的编译路径，稍后更新。

### 发布地址：

https://github.com/klever1988/nanopi-openwrt/releases  
(请记得下载zip包之后解压出里头的固件包再刷，不要拿zip直刷，会失败的！)

### 固件源码：

https://github.com/immortalwrt/immortalwrt

### 温馨提示：

默认用户名是root, 密码是password
烧制完固件插入tf卡并启动完成，电脑端显示“网络（已连接）”之后，在浏览器输入 http://immortalwrt/ 可以直接打开路由器后台，无需修改本地连接设置或者查看IP地址。如果网络状态一直是未识别（上电超过5分钟），请直接插拔一次电源重启试试。

### 终端内在线升级方法:	
先安装好依赖
```bash
opkg update
opkg install --force-overwrite pv fdisk
```
然后下载脚本执行
```bash	
wget -qO- https://github.com/klever1988/nanopi-openwrt/raw/master/scripts/autoupdate.sh | sh
```	
(脚本由gary lau提供，非常感谢！)

### 更新说明：

https://github.com/klever1988/nanopi-openwrt/blob/master/CHANGELOG.md

#### 本固件(minimal版本)NAT基准性能测试：

<img src="https://github.com/klever1988/nanopi-openwrt/raw/master/assets/NAT.jpg" width="600" /><img src="https://raw.githubusercontent.com/klever1988/nanopi-openwrt/master/assets/Acc.jpg" width="250" />
