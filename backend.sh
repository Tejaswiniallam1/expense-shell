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

Head  "remove existing App content"
rm -rf /app &>>log_file
echo $?

Head  "create application directory"
mkdir /app &>>log_file
echo $?

Head  "download Application content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
cd /app &>>log_file
echo $?

Head  "extracting the application content"
unzip /tmp/backend.zip &>>log_file
echo $?

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