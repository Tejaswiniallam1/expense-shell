echo Disable nodejs version

dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y
cp backend.service /etc/systemd/system/backend.service

useradd expense
rm -rf /app
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
pwd
cd /app
unzip /tmp/backend.zip
npm install
## its interesting.
systemctl daemon-reload
systemctl enable backend
systemctl start backend

dnf install mysql -y
mysql -h mysql-dev.tejudevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql