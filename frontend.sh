MYSQL_PASSWORD=$1
Component=frontend

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

App_Prereq "/user/share/nginx/html"

Head "Start Nginx Service"
systemctl enable nginx
systemctl restart nginx
echo $?