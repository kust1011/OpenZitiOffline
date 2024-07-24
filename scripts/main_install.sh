#!/bin/bash

function _check_dependencies {
    local DEPENDENCIES_PATH="../binaries/dependencies"

    # 檢查傳入的每個相依性是否已安裝
    for dependency in "$@"; do
        if ! command -v "$dependency" >/dev/null 2>&1; then
            echo "$dependency 未安裝。正在嘗試將其複製到 /usr/local/bin。"

            # 檢查二進位檔案是否存在於DEPENDENCIES_PATH中
            if [ -f "$DEPENDENCIES_PATH/$dependency" ]; then
                # 嘗試複製到/usr/local/bin
                sudo cp "$DEPENDENCIES_PATH/$dependency" /usr/local/bin/
                sudo chmod +x /usr/local/bin/$dependency  # 確保可執行權限

                if command -v "$dependency" >/dev/null 2>&1; then
                    echo "$dependency 現在在 /usr/local/bin 中可用。"
                else
                    echo "無法安裝 $dependency."
                fi
            else
                echo "$DEPENDENCIES_PATH 中不存在 $dependency 的二進位檔案。"
            fi
        fi
    done

}

function _configure_ufw {
    declare -a ports=("22/tcp" "8440/tcp" "8441/tcp" "8442/tcp" "8443/tcp" "10080/tcp")
    for port in "${ports[@]}"; do
        if ! sudo ufw status | grep -q "$port"; then
            echo "Allowing $port through the firewall."
            sudo ufw allow $port
        else
            echo "$port 已被允許。"
        fi
    done

    sudo ufw enable
    sudo ufw status verbose

    echo "UFW 配置完成"
}

function _setup_environment {
    source ../config/ziti.env
}

function _setup_ziti_services {
    # 啟用並啟動 Controller 和 Router 的 Systemd 服務
    sudo cp "${ZITI_HOME}/${ZITI_CTRL_NAME}.service" /etc/systemd/system/ziti-controller.service
    sudo cp "${ZITI_HOME}/${ZITI_ROUTER_NAME}.service" /etc/systemd/system/ziti-router.service

    # 重新載入 systemd 管理器配置
    sudo systemctl daemon-reload

    sudo systemctl enable --now ziti-controller
    sudo systemctl enable --now ziti-router

    # 顯示服務狀態
    sudo systemctl -q status ziti-controller --lines=0 --no-pager
    sudo systemctl -q status ziti-router --lines=0 --no-pager

    echo "Controller 和 Router 的 Systemd 服務已啟動並設置為開機自動啟動。"
}

function _undo_setup_ziti_services {
    # 停止服務
    sudo systemctl stop ziti-controller
    sudo systemctl stop ziti-router

    # 禁用服務自動啟動
    sudo systemctl disable ziti-controller
    sudo systemctl disable ziti-router

    # 刪除 Systemd 服務檔案
    sudo rm -f /etc/systemd/system/ziti-controller.service
    sudo rm -f /etc/systemd/system/ziti-router.service

    # 重新載入 systemd 管理器配置
    sudo systemctl daemon-reload

    echo "Controller 和 Router 的 Systemd 服務已停止並刪除。"
}


echo "開始離線 Ziti 安裝..."

echo -e "\n--- 檢查安裝相依性 ---"
_check_dependencies jq curl
echo "--- 相依性檢查完成 ---"

echo -e "\n--- 設定防火牆規則 ---"
_configure_ufw
echo "--- 防火牆設定完成 ---"

echo -e "\n--- 設定環境變數 ---"
_setup_environment
echo "--- 環境變數設定完成 ---"

echo -e "\n--- 開始執行安裝主程式 ---"
source ./ziti-cli-functions.sh
expressInstall
echo "--- 安裝完成 ---"

echo -e "\n--- 產生服務單元 ---"
# 創建 Controller 和 Router 的 Systemd 服務文件
createControllerSystemdFile
createRouterSystemdFile "${ZITI_ROUTER_NAME}"
_setup_ziti_services
echo "--- 已建立服務單元 ---"

source ~/.ziti/quickstart/$(hostname -s)/$(hostname -s).env >>  .bashrc
echo -e "\n--- 已添加環境變數 ---"

echo -e "\nZiti 已安裝並啟動成功。"