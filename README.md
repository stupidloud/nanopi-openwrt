## Nanopi r1s(h5) r2s openwrt 固件自动编译

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


#### 本固件(minimal版本)NAT基准性能测试：

![NAT](https://github.com/klever1988/nanopi-openwrt/raw/master/assets/NAT.jpg)
![Acc](https://raw.githubusercontent.com/klever1988/nanopi-openwrt/master/assets/Acc.jpg)
