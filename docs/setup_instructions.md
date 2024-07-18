# OpenZiti 環境設定指南

歡迎使用 OpenZiti！為了確保你的 OpenZiti 環境正確配置和運行，本文件將引導你通過必要的設定步驟。

## 首要步驟：設定環境變數

在啟動任何 OpenZiti 服務之前，請確保已正確設定環境變數。這是透過來源（source）`ziti.env` 檔案完成的，該檔案包含了運行 OpenZiti 所需的所有必要環境變數。

### 執行以下命令：

打開你的終端，並執行以下命令：

```bash
source ~/Desktop/OpenZitiOffline/config/ziti.env
```