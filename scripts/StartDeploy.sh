BUILD_JAR=$(ls /home/ec2-user/CI-CD-Test/build/libs/*.jar)  # 프로젝트 내 jar 파일 경로를 불러와 빌드
JAR_NAME=$(basename $BUILD_JAR) # 위에서 빌드한 jar 파일을 저장
echo "> build 파일명: $JAR_NAME" >>/home/ec2-user/CI-CD-Test/build/libs/*.jar

echo "> build 파일 복사" >> /home/ec2-user/script/StartDeploy.sh
DEPLOY_PATH=/home/ec2-user/script/
cp $BUILD_JAR $DEPLOY_PATH

echo "> 현재 실행중인 애플리케이션 pid 확인" >>/home/ec2-user/CI-CD-Test/build/libs/*.jar
CURRENT_PID=$(pgrep -f $JAR_NAME)

if [ -z $CURRENT_PID ]
then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다." >>/home/ec2-user/CI-CD-Test/build/libs/*.jar
else
  echo "> kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

DEPLOY_JAR=$DEPLOY_PATH$JAR_NAME
echo "> DEPLOY_JAR 배포"    >> /home/ec2-user/script/StartDeploy.sh
nohup java -jar $DEPLOY_JAR >> /home/ec2-user/deploy.log 2>/home/ec2-user/CI-CD-Test/build/libs/*.jar &
