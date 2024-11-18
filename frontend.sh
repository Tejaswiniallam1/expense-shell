MYSQL_PASSWORD=$1

source common.sh

Head(){
  echo -e "\e[35m$1\e[0m"
}
Head "Install Nginx Server"
dnf install nginx -y
echo $?

Head "Copy expense config file"
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

Head "Remove the old/default content"
rm -rf /usr/share/nginx/html/*
echo $?

Head "Download Application code"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
echo $?

Head "Extract Application code"
unzip /tmp/frontend.zip
echo $?

Head "Start Nginx Service"
systemctl enable nginx
systemctl restart nginx
echo $?