sudo -u root -H sh <<EOF
apt-get update -y
apt-get install -y ruby2.3 ruby2.3-dev git nodejs libmysqlclient20 libmysqlclient-dev r-base nginx
cp /home/std/system/nginx.default /etc/nginx/sites-available/default
gem install bundler 
EOF

sudo -u std -H sh <<EOF
cd /home/std/associative-experiment/
. /home/std/associative-experiment/variables
bundle install --deployment
EOF

sudo -u root -H sh <<EOF
ln -s /home/std/system/unicorn /etc/service/
ln -s /home/std/system/nginx /etc/service/
EOF
