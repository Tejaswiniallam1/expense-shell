log_file=/tmp/expense.log
MYSQL_PASSWORD=$1
Head(){
  echo -e "\e[$1\e[0m"
}
Head  "Disable nodejs existing version"
dnf module disable nodejs -y &>>log_file

Head  "Enable NODEJS18 Version"
dnf module enable nodejs:18 -y &>>log_file

Head  "install NODEJS"
dnf install nodejs -y &>>log_file

Head  "Configure Backend Service"
cp backend.service /etc/systemd/system/backend.service &>>log_file

Head  "Add application user"
useradd expense &>>log_file

Head  "remove existing App content"
rm -rf /app &>>log_file

Head  "create application directory"
mkdir /app &>>log_file

Head  "download Application content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
cd /app &>>log_file

Head  "extracting the application content"
unzip /tmp/backend.zip &>>log_file

Head  "downloading application dependencies"
npm install &>>log_file

Head "reloading the systemd and start backend server"
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl start backend &>>log_file

Head "install mysql client"
dnf install mysql -y &>>log_file

Head "load schema"
mysql -h mysql-dev.tejudevops.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>log_file
## >/dev/null -- this command used to not store the data into the disk.