git clone --depth=1 https://github.com/destan19/OpenAppFilter.git && rm -r package/OpenAppFilter && mv OpenAppFilter package/
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git && rm -r package/lean/luci-theme-argon && mv luci-theme-argon package/lean/
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cifsd && rm -r package/lean/luci-app-ksmbd && mv luci-app-cifsd package/lean/
