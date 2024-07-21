# OpenZiti 離線安裝指南

本專案包含了一系列腳本和必要的二進制文件，用於在離線環境中設置 OpenZiti。
OpenZiti 提供了一個安全的開源網路覆蓋層解決方案，非常適合安全地訪問應用程式、數據庫和服務。

## 前置條件：
確保您擁有機器的管理員訪問權限，因為腳本可能需要 sudo 權限來執行。

## 安裝：

按照以下步驟設置 OpenZiti：

1. 下載專案：
```bash
    git clone https://github.com/kust1011/OpenZitiOffline.git
    cd OpenZitiOffline
```
2. 導航到腳本目錄：
```bash
    cd scripts
```
3. 執行主安裝腳本：
```bash
    . main_install.sh
```
