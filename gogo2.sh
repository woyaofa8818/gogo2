#!/bin/bash
# 下载和安装 gost
wget https://github.com/go-gost/gost/releases/download/v3.0.0-rc8/gost_3.0.0-rc8_linux_amd64v3.tar.gz
tar -zxvf gost_3.0.0-rc8_linux_amd64v3.tar.gz
mv gost /usr/local/bin/
chmod +x /usr/local/bin/gost

# 创建 Systemd 服务
echo "[Unit]
Description=Gost Proxy Service
After=network.target

[Service]
ExecStart=/usr/local/bin/gost \
-L \"http://woyaofa:woyaofa@:20080?limiter.in=50MB&limiter.out=50MB&climiter=111\" \
-L \"socks5://woyaofa:woyaofa@:10800?udp=true&limiter.in=50MB&limiter.out=50MB&climiter=111\" \
-L \"ss://aes-256-gcm:Pofeng@5188.8@:5188?limiter.in=50MB&limiter.out=50MB&climiter=111\" \
-L \"ssu+udp://aes-256-gcm:Pofeng@5188.8@:5188?limiter.in=50MB&limiter.out=50MB&climiter=111\"
Restart=always

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/gost.service

# 重载 Systemd 并激活 gost
sudo systemctl daemon-reload
sudo systemctl enable gost
sudo systemctl start gost