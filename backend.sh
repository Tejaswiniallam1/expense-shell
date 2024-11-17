log_file=/tmp/expense.log
MYSQL_PASSWORD=$1
echo -e  "\e[35m Disable nodejs existing version\e[0m"
dnf module disable nodejs -y &>>log_file

echo -e  "\e[35m Enable NODEJS18 Version\e[0m"
dnf module enable nodejs:18 -y &>>log_file

echo -e  "\e[35m install NODEJS\e[0m"
dnf install nodejs -y &>>log_file

echo -e  "\e[35m Configure Backend Service\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>log_file

echo -e  "\e[35m add application user\e[0m"
useradd expense &>>log_file

echo -e  "\e[35m remove existing App content\e[0m"
rm -rf /app &>>log_file

echo -e  "\e[35m create application directory\e[0m"
mkdir /app &>>log_file

echo -e  "\e[35m download Application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
cd /app &>>log_file

echo -e  "\e[35m extracting the application content\e[0m"
unzip /tmp/backend.zip &>>log_file

echo -e  "\e[35m downloading application dependencies\e[0m"
npm install &>>log_file

echo -e "\e[35m reloading the systemd and start backend server\e[0m"
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl start backend &>>log_file

echo -e "\e[35m install mysql client\e[0m"
dnf install mysql -y &>>log_file

echo -e "\e[35m load schema\e[0m"
mysql -h mysql-dev.tejudevops.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>log_file
## >/dev/null -- this command used to not store the data into the disk.