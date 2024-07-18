#!/bin/bash

# 創建 Controller 和 Router 的 Systemd 服務文件
createControllerSystemdFile
createRouterSystemdFile "${ZITI_ROUTER_NAME}"

# 重新載入 systemd 管理器配置
sudo systemctl daemon-reload

# 啟用並啟動 Controller 和 Router 的 Systemd 服務
sudo systemctl enable ziti-controller.service
sudo systemctl start ziti-controller.service

sudo systemctl enable ziti-router-${ZITI_ROUTER_NAME}.service
sudo systemctl start ziti-router-${ZITI_ROUTER_NAME}.service

# 顯示服務狀態
sudo systemctl status ziti-controller.service
sudo systemctl status ziti-router-${ZITI_ROUTER_NAME}.service

echo "Controller 和 Router 的 Systemd 服務已啟動並設置為開機自動啟動。"
