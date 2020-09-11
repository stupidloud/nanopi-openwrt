git clone https://github.com/friendlyarm/repo
sudo cp repo/repo /usr/bin/
mkdir friendlywrt-$2
cd friendlywrt-$2
repo init -u https://github.com/friendlyarm/friendlywrt_manifests -b $1 -m $2.xml --repo-url=https://github.com/friendlyarm/repo --no-clone-bundle --depth=1
repo sync -c --no-tags --no-clone-bundle -j8
cd friendlywrt/ && git fetch --unshallow
git checkout `git branch -va | grep remotes/m | awk '{print $3}' | awk -F\/ '{print $2}'`

[ -f target/linux/rockchip-rk3328/config-4.14 ] && sed -i '/CONFIG_CGROUPS/a\CONFIG_CGROUP_PERF=y' target/linux/rockchip-rk3328/config-4.14
[ -f target/linux/allwinner-h5/config-4.14 ] &&    sed -i '/CONFIG_CGROUPS/a\CONFIG_CGROUP_PERF=y' target/linux/allwinner-h5/config-4.14
git add . && git commit -m 'reset'

cd ../ && find device/ -name distfeeds.conf -delete
