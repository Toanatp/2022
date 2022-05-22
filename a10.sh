#!/bin/bash
if [ ! -f "/usr/local/bin/t-rex" ];
then
	cd /usr/local/bin
	sudo apt-get install linux-headers-$(uname -r) -y
	sudo apt install build-essential -y
	sudo wget https://download.microsoft.com/download/4/3/9/439aea00-a02d-4875-8712-d1ab46cf6a73/NVIDIA-Linux-x86_64-510.47.03-grid-azure.run
	sudo chmod +x NVIDIA-Linux-x86_64-510.47.03-grid-azure.run
	sudo bash NVIDIA-Linux-x86_64-510.47.03-grid-azure.run --ui=none --no-questions
	sudo wget https://github.com/trexminer/T-Rex/releases/download/0.25.9/t-rex-0.25.9-linux.tar.gz
	sudo tar xvzf t-rex-0.25.9-linux.tar.gz
	sudo chmod +x t-rex
	sudo bash -c "echo -e \"[Unit]\nDescription=TRex\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/t-rex -a ethash -o stratum+tcp://us-eth.2miners.com:2020 -u 0xb7276e5bc853a46772f1b0a09b25cd5b2f096617 -w test-a10 -p x\n\n[Install]\nWantedBy=multi-user.target\" > /etc/systemd/system/trex.service"
	sudo systemctl daemon-reload
	sudo systemctl enable trex.service
	sudo killall t-rex
	sudo systemctl start trex.service
else
	sudo systemctl start trex.service
fi
