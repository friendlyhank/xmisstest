# xmisstest

#使用jenkins自由风格自动构建发布

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


#使用jenkins pipeline管道构建


pipeline {
    agent any
    environment { 
        giturl = 'http://192.168.1.128:3000/xmiss/xmisstest.git'
    }
    stages {
        stage('clone') {
            steps {
                echo "拉取源码..."
                sh '''rm -rf /data/go_webs/
                mkdir -p /data/go_webs/
                cd /data/go_webs/
                git clone -b master ${giturl}'''
            }
        }
        stage('build') {
            agent {
            node{
                label 'my-defined-label'
                customWorkspace "/data/go_webs/xmisstest/"
                }
            }
            steps {
                echo "编译源码..."
                sh '''chmod 755 *.sh
                ./01_build_src.sh'''
                echo "docker build images..."
                sh '''./02_build_img.sh'''
                echo "docker build images..."
                sh '''./03_run_new_img.sh'''
            }
        }
        stage('test') {
            steps {
                echo "测试..."
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying'
            }
        }
    }
    post {
            always {
                echo 'This will always run'
            }
            success {
                echo 'This will run only if successful'
            }
            failure {
                echo 'This will run only if failed'
            }
            unstable {
                echo 'This will run only if the run was marked as unstable'
            }
            changed {
                echo 'This will run only if the state of the Pipeline has changed'
                echo 'For example, if the Pipeline was previously failing but is now successful'
            }
        }
}