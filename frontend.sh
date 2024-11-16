dnf install nginx -y

rm -rf /usr/share/nginx/html/*

cd /usr/share/nginx/html
unzip /tmp/frontend.zip
cp expense.conf /etc/nginx/default.d/expense.conf
systemctl enable nginx
systemctl restart nginx