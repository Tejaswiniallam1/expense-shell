dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y
cp Backend Service /etc/systemd/system/backend.service

useradd expense
rm -rf /app
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
npm install
unzip /tmp/backend.zip
systemctl daemon-reload

systemctl enable backend
systemctl start backend

dnf install mysql -y
mysql -h 34.204.90.151 -uroot -pExpenseApp@1 < /app/schema/backend.sql