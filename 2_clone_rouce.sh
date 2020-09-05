git clone https://github.com/friendlyarm/repo
sudo cp repo/repo /usr/bin/
mkdir friendlywrt-$2
cd friendlywrt-$2
repo init -u https://github.com/friendlyarm/friendlywrt_manifests -b $1 -m $2.xml --repo-url=https://github.com/friendlyarm/repo --no-clone-bundle --depth=1
repo sync -c --no-tags --no-clone-bundle -j8
cd friendlywrt/ && git fetch --unshallow
git checkout `git branch -va | grep remotes/m | awk '{print $3}' | awk -F\/ '{print $2}'`
