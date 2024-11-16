dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
useradd expense
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip
systemctl daemon-reload

systemctl enable backend
systemctl start backend

dnf install mysql -y
mysql -h 34.204.90.151 -uroot -pExpenseApp@1 < /app/schema/backend.sql