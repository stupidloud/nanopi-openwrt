## Nanopi r1s r2s openwrt 固件自动编译

### 发布地址：

https://github.com/klever1988/nanopi-openwrt/releases  
(请记得下载zip包之后解压出里头的固件包再刷，不要拿zip直刷，会失败的！)

### 编译方式：

本编译方案采用git rebase(变基)，把友善friendlywrt对openwrt代码的修改应用到Lean和Lienol两个大佬的openwrt分支，并替换friendlywrt整套代码的方式，由此编译出分别包含两位大佬特色优化和插件的两版固件，寻求最佳的插件兼容性和稳定性。而minimal版是我根据自己的理解，在Lean版的基础上只编译我认为不影响设备性能的插件。目前测试结果显示，minimal虽然功能较少，但是性能是比较好的。

### 温馨提示：

Lean版的默认用户名是root, 密码是password  
Lienol版默认用户名是root, 密码为空

烧制完固件插入tf卡并启动完成，电脑端显示“网络（已连接）”之后，在浏览器输入 http://friendlywrt/ 可以直接打开路由器后台，无需修改本地连接设置或者查看IP地址。如果网络状态一直是未识别（上电超过5分钟），请直接插拔一次电源重启试试。

### 更新说明：

https://github.com/klever1988/nanopi-openwrt/blob/master/CHANGELOG.md

### R2S在线升级方法:
(注意:目前仅支持R2S，仅能升级到minimal版本固件，如果你使用的是Lienol版也不要用此方法升级)  
先安装好依赖
```bash
opkg update
opkg install zstd
opkg install libzstd
```
然后下载脚本执行
```bash
wget -qO- https://github.com/klever1988/nanopi-openwrt/raw/master/scripts/autoupdate.sh | sh
```
(脚本由gary lau提供，非常感谢！)

### R2S离线升级方法:
(注意:目前仅支持R2S，仅能升级到minimal版本固件，如果你使用的是Lienol版也不要用此方法升级)
把下载好的 release固件 上传到R2S（系统 -> 文件传输 -> 上传）
把下载好的scripts目录下的 autoupdate-offline.sh 上传到R2S（系统 -> 文件传输 -> 上传）
然后脚本执行
```bash
sh /tmp/upload/autoupdate-offline.sh
```
#### 本固件(minimal版本)NAT基准性能测试：

<img src="https://github.com/klever1988/nanopi-openwrt/raw/master/assets/NAT.jpg" width="600" /><img src="https://raw.githubusercontent.com/klever1988/nanopi-openwrt/master/assets/Acc.jpg" width="250" />
