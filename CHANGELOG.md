
# 更新日志
###### （如果没有特别说明，更新内容就是上游Lean和Lienol两位大佬的代码更新）

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
