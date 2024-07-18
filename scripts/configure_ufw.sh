#!/bin/bash

# 更新套件清單並安裝 UFW（如果尚未安裝）
sudo apt-get update
sudo apt-get install -y ufw

# 允許 SSH 連接
sudo ufw allow 22/tcp

# 讓 Edge Controller 提供路由器控制平面
sudo ufw allow 8440/tcp

# 讓 Edge Controller 提供用戶端會話
sudo ufw allow 8441/tcp

# 允許 Edge Router 提供客戶端連接
sudo ufw allow 8442/tcp

# 允許 Ziti Admin Console (ZAC) [可選]
sudo ufw allow 8443/tcp

# 允許 Fabric Router 連結監聽器
sudo ufw allow 10080/tcp

# 啟用 UFW 防火牆
sudo ufw enable

# 顯示 UFW 狀態和規則
sudo ufw status verbose

echo "UFW 配置完成，允許的連接埠包括：22/tcp, 8440/tcp, 8441/tcp, 8442/tcp, 8443/tcp, 10080/tcp"