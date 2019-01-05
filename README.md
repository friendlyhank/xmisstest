# xmisstest


#1.下载源码 git clone
echo "拉取源码..."
rm -rf /data/go_webs/
mkdir -p /data/go_webs/
cd /data/go_webs/

#-b指定分支
git clone -b master http://192.168.1.128:3000/xmiss/xmisstest.git


#2.编译源码
echo "编译源码..."
cd /data/go_webs/xmisstest/
chmod 755 *.sh
./01_build_src.sh

#3.测试
echo "测试..."

#4.生成docker image
echo "docker build images..."
./02_build_img.sh

#5.推送docker image
echo "git push"


#6.通知APP service 跑新的Image
./03_run_new_img.sh

#7--112244
