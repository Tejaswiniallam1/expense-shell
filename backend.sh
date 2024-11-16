echo Disable nodejs existing version
dnf module disable nodejs -y

echo Enable NODEJS18 Version
dnf module enable nodejs:18 -y

echo install NODEJS
dnf install nodejs -y

echo Configure Backend Service
cp backend.service /etc/systemd/system/backend.service

echo add application user
useradd expense

echo remove existing App content
rm -rf /app

echo create application directory
mkdir /app

echo download Application content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app

echo extracting the application content
unzip /tmp/backend.zip

echo downloading application dependencies
npm install

echo reloading the systemd and start backend server
systemctl daemon-reload
systemctl enable backend
systemctl start backend

echo install mysql client
dnf install mysql -y

echo load schema
mysql -h mysql-dev.tejudevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql