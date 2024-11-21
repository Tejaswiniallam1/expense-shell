MYSQL_PASSWORD=$1
if [ -z "$MYSQL_PASSWORD"];then
  echo Input MYSQL_PASSWORD is incorrect.
  exit 1
fi
Component=backend
source common.sh

Head  "Disable nodejs existing version"
dnf module disable nodejs -y &>>log_file
Stat $?

Head  "Enable NODEJS18 Version"
dnf module enable nodejs:18 -y &>>log_file
Stat $?

Head  "install NODEJS"
dnf install nodejs -y &>>log_file
Stat $?

Head  "Configure Backend Service"
cp backend.service /etc/systemd/system/backend.service &>>log_file
Stat $?

Head  "Add application user"
id expense &>>log_file
if [ "$?" -ne 0 ]; then
useradd expense &>>log_file
fi
Stat $?

App_Prereq /app


Head  "downloading application dependencies"
npm install &>>log_file
Stat $?

Head "reloading the systemd and start backend server"
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl start backend &>>log_file
Stat $?

Head "install mysql client"
dnf install mysql -y &>>log_file
Stat $?

Head "load schema"
mysql -h mysql-dev.tejudevops.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>log_file
Stat $?

## >/dev/null -- this command used to not store the data into the disk.