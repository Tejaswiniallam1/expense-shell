MYSQL_PASSWORD=$1
Component=backend
source common.sh

Head  "Disable nodejs existing version"
dnf module disable nodejs -y &>>log_file
echo $?

Head  "Enable NODEJS18 Version"
dnf module enable nodejs:18 -y &>>log_file
echo $?

Head  "install NODEJS"
dnf install nodejs -y &>>log_file
echo $?

Head  "Configure Backend Service"
cp backend.service /etc/systemd/system/backend.service &>>log_file
echo $?

Head  "Add application user"
useradd expense &>>log_file
echo $?

App_Prereq /app


Head  "downloading application dependencies"
npm install &>>log_file
echo $?

Head "reloading the systemd and start backend server"
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl start backend &>>log_file
echo $?

Head "install mysql client"
dnf install mysql -y &>>log_file
echo $?

Head "load schema"
mysql -h mysql-dev.tejudevops.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>log_file
echo $?

## >/dev/null -- this command used to not store the data into the disk.