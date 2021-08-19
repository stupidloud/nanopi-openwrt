
# 更新日志
###### （如果没有特别说明，更新内容就是上游Lean和Lienol两位大佬的代码更新）

## 2021-08-19

- 增加机型：NanoPi R2C 的支持（由@thomaswcy提供支持）

## 2021-03-13

- autoupdate.sh脚本实验性功能：升级固件时自动扩容分区至sd卡最大值
- 添加Diskman和ddnsto插件

## 2021-03-11

- R2S主频限制预设1.5GHz(你仍然可以解锁至1.6GHz)

## 2021-03-10

- 添加百度云，transmission插件
- 固定dropbear服务端的host key，这样每次升级固件后连接ssh都不会弹出公钥警告了

## 2021-03-06

- Lan IP固定为192.168.2.1

## 2021-03-05

- R2S恢复添加友善的风扇控制脚本、以及oled显示屏的控制插件

## 2021-03-04

- 固定编译的路径，使编译缓存在forks的编译中仍然有效，fork自定义编译只需30分钟

## 2021-02-27

- 改用Tianling Shen的immortalwrt源码产出固件

## 2020-08-05

- R2S加入了 https://github.com/NateLol/luci-app-oled 支持oled状态显示

![oled](https://github.com/klever1988/nanopi-openwrt/raw/master/assets/oled.jpg)

## 2020-08-04

- 改用Lean大的稳定分支版本 https://github.com/coolsnowwolf/openwrt 进行编译，修复了usb无线网卡的死机问题

## 2020-03-25

- r2s现已支持在线升级，并且升级能够保存设置，需要通过ssh实施。提醒，脚本只支持升级到minimal系统。

## 2020-03-14

- 添加大雕的autocore网卡软中断负载均衡插件，如果你不懂这是啥，其实我也不太懂。大概意思是让网卡的软中断需求平均地分部在4个CPU核心上。

## 2020-03-13

- 内核解锁R2S CPU 1.296 Ghz的限制，突发频率提升至RK3328该有的1.512Ghz，当然电压也会随之提高，你需要优秀的散热条件。当然也不必担心过热，因为到了温度阙值就自动降频了。

## 2020-03-12

- R2S添加了无线网卡支持，型号rtl8821CU。友情提醒：驱动问题，导致所有5G网卡的连接速率只有54M。

## 2020-03-11

- 增加两个一个R1S(H3)的版本，基于Lean分支编译，未测试
- 去掉了cpufreq调节插件（大雕最近加到默认编译包的），貌似这个插件会把cpu峰值频率压低到1ghz以内。避免麻烦，就不带这个插件了。

## 2020-03-10

- 去掉了VSSR插件，这个插件存在bug，未配置的情况下会启动无验证的socks代理工作于WAN端口上，这会导致路由器存在被滥用为公共代理服务器的风险。

## 2020-03-09

- 不少人反应用r2s拨号缺少硬路由的断线自动重拨功能，存在长时间使用被运营商踢下线又没有自动重拨，遂加上Watchcat插件。

## 2020-03-06

- 今天给R1S尝试打入4.14的内核补丁但是发现bug不少，想要开启acc还得手动modprobe xt_FLOWOFFLOAD模块，并且无法通过后台或者命令重启，所以暂时取消补丁了。有兴趣的人研究一下。

## 2020-03-05

- R2S Lean版和Lienol版加入内核补丁，可以打开flow加速了
- Minimal恢复支持ipv6

## 2020-03-04

- 今天暂停更新其他版本，只更新minimal版。内核打入Openwrt官方的鸡血补丁，NAT性能有了炸天的表现。

![boom](https://raw.githubusercontent.com/klever1988/nanopi-openwrt/master/assets/boom.jpg)

## 2020-03-01

- 增加一版功能简单，但是性能更加优秀的minimal版本。如果对插件没有特殊需求，建议使用此版固件。后续遇到插件需求，我倾向于在两位大佬版本的固件上增加。

## 2020-02-29

- ~~lean版添加了一个临时分支版本（建议先测试），具体就是端口对调，据测有蜜汁性能提升(仅针对把r2s用作旁路由的用户)~~
- [commit](https://github.com/friendlyarm/uboot-rockchip/commit/bd263a5cedaea8f2c5214bdca02a2fd0af29dcd0)，修复了路由器重启时windows提示连接到新网络的错误提示

## 2020-02-28

- lienol版添加了广告过滤大师plus(adbyby plus)以及adguardhome，修正了温度添加格式不正确
- lean版添加老竭力的[Hello world](https://github.com/jerrykuku/luci-app-vssr)插件，更新[Argon](https://github.com/jerrykuku/luci-theme-argon)主题并设为默认主题，并添加回27日丢失的[白嫖网易云插件Mini Ver.](https://github.com/project-openwrt/luci-app-unblockneteasemusic-mini)

## 2020-02-27

- lan和wan状态灯亮了...

## 2020-02-25

- 略...
