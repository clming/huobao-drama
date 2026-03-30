# Huobao Drama 安装与启动说明

本文档说明 `Huobao Drama` 项目在本地开发、Docker 运行、以及 CentOS/Linux 部署时的常用安装、编译和启动方法。

适用目录：
[`huobao-drama`](d:/GitHub/huobao-drama)

## 1. 项目依赖

本项目主要依赖以下工具：

- Go `1.23.x`
- Node.js `20.16.0`
- npm
- FFmpeg
- Docker

说明：

- 前端统一使用 `nvm` 管理 Node 版本。
- 你当前机器上推荐使用的 Go 路径为：
  [`D:\Program Files\Go1.23.1`](d:/Program%20Files/Go1.23.1)
- 后续新增工具、缓存和构建产物，优先放在 `D:` 盘。

## 2. 安装 Node.js 并使用 nvm 管理

### 2.1 安装 nvm for Windows

如果本机还没有安装 `nvm`，可先安装 `nvm-windows`：

1. 打开发布页：`https://github.com/coreybutler/nvm-windows/releases`
2. 下载并安装 `nvm-setup.exe`
3. 安装完成后，重新打开终端

验证：

```powershell
nvm version
```

### 2.2 安装项目所需 Node 版本

本项目统一使用：

```text
20.16.0
```

安装并切换版本：

```powershell
nvm install 20.16.0
nvm use 20.16.0
node -v
npm -v
```

仓库内已提供版本约束：

- [`/.nvmrc`](d:/GitHub/huobao-drama/.nvmrc)
- [`/web/.nvmrc`](d:/GitHub/huobao-drama/web/.nvmrc)
- [`/web/package.json`](d:/GitHub/huobao-drama/web/package.json)

## 3. 安装 Go 1.23，并保留原有 Go 版本

本项目要求见：
[`go.mod`](d:/GitHub/huobao-drama/go.mod)

当前要求：

```text
go 1.23.0
```

如果你电脑里已经装了旧版 Go，不需要卸载。建议额外安装一个 `Go 1.23.x`，专门用于本项目。

推荐路径：

```text
D:\Program Files\Go1.23.1
```

验证：

```powershell
& 'D:\Program Files\Go1.23.1\bin\go.exe' version
```

## 4. 安装 FFmpeg

本项目的视频处理依赖 `FFmpeg`。

### Windows 安装方式

1. 打开官网：`https://ffmpeg.org/download.html`
2. 下载 Windows 版本
3. 解压后将 `ffmpeg.exe` 所在目录加入系统 `PATH`

验证：

```powershell
ffmpeg -version
```

## 5. 安装项目依赖

### 5.1 克隆项目

```powershell
git clone https://github.com/chatfire-AI/huobao-drama.git
cd huobao-drama
```

### 5.2 安装后端依赖

```powershell
& 'D:\Program Files\Go1.23.1\bin\go.exe' mod download
```

### 5.3 安装前端依赖

```powershell
nvm use 20.16.0
cd web
npm install
cd ..
```

前端目录：
[`web`](d:/GitHub/huobao-drama/web)

## 6. 配置项目

配置模板文件：
[`configs/config.example.yaml`](d:/GitHub/huobao-drama/configs/config.example.yaml)

复制为实际配置文件：

```powershell
Copy-Item .\configs\config.example.yaml .\configs\config.yaml
```

生成后的配置文件：
[`configs/config.yaml`](d:/GitHub/huobao-drama/configs/config.yaml)

默认配置示例：

```yaml
app:
  name: "Huobao Drama API"
  version: "1.0.0"
  debug: true

server:
  port: 5678
  host: "0.0.0.0"
  cors_origins:
    - "http://localhost:3012"
    - "http://localhost:5678"
    - "http://127.0.0.1:5678"

database:
  type: "sqlite"
  path: "./data/drama_generator.db"

storage:
  type: "local"
  local_path: "./data/storage"
  base_url: "http://localhost:5678/static"
```

## 7. 启动项目

### 7.1 开发模式启动

推荐开发时使用前后端分离方式。

终端 1：启动 Go 后端

```powershell
& 'D:\Program Files\Go1.23.1\bin\go.exe' run .\main.go
```

终端 2：启动前端

推荐方式：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\run-frontend-dev.ps1
```

默认地址：

- 前端：`http://localhost:3012`
- 后端 API：`http://localhost:5678/api/v1`
- 健康检查：`http://localhost:5678/health`

### 7.2 单服务模式启动

前端构建：

```powershell
& 'D:\Users\cao_l\AppData\Local\nvm\v20.16.0\node.exe' .\web\node_modules\vite\bin\vite.js build
```

后端启动：

```powershell
& 'D:\Program Files\Go1.23.1\bin\go.exe' run .\main.go
```

## 8. 编译 Go 后端

验证后端能否编译：

```powershell
New-Item -ItemType Directory -Force -Path .\.gocache | Out-Null
$env:GOROOT='D:\Program Files\Go1.23.1'
$env:PATH='D:\Program Files\Go1.23.1\bin;' + $env:PATH
$env:GOTOOLCHAIN='local'
$env:GOCACHE=(Join-Path (Get-Location) '.gocache')
& 'D:\Program Files\Go1.23.1\bin\go.exe' build ./...
```

## 9. 编译 Node 前端

当前机器上，推荐直接使用 `node + vite` 的方式构建前端：

```powershell
& 'D:\Users\cao_l\AppData\Local\nvm\v20.16.0\node.exe' .\web\node_modules\vite\bin\vite.js build
```

产物目录：
[`web/dist`](d:/GitHub/huobao-drama/web/dist)

## 10. VS Code 中为项目指定 Go 1.23

工作区设置文件：
[`/.vscode/settings.json`](d:/GitHub/huobao-drama/.vscode/settings.json)

当前推荐配置：

```json
{
  "files.encoding": "utf8",
  "go.toolsEnvVars": {
    "GOROOT": "D:\\Program Files\\Go1.23.1"
  }
}
```

## 11. Windows 终端中文乱码说明

如果 Markdown 文件在 PowerShell 中显示乱码，但在 VS Code 编辑器里显示正常，通常是终端编码问题。

可先执行：

```powershell
chcp 65001
[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
```

再查看文件：

```powershell
Get-Content README.md
Get-Content Readme-install.md
```

## 12. 当前仓库中的关键文件

- 安装文档：[`Readme-install.md`](d:/GitHub/huobao-drama/Readme-install.md)
- 项目说明：[`README.md`](d:/GitHub/huobao-drama/README.md)
- Go 模块声明：[`go.mod`](d:/GitHub/huobao-drama/go.mod)
- 后端入口：[`main.go`](d:/GitHub/huobao-drama/main.go)
- 配置模板：[`configs/config.example.yaml`](d:/GitHub/huobao-drama/configs/config.example.yaml)
- 前端版本声明：[`web/package.json`](d:/GitHub/huobao-drama/web/package.json)

## 13. VS Code 一键启动

当前仓库已提供 VS Code 任务文件：
[`/.vscode/tasks.json`](d:/GitHub/huobao-drama/.vscode/tasks.json)

可直接在 VS Code 中使用：

1. 打开 `Terminal -> Run Task`
2. 选择 `backend: run` 启动后端
3. 选择 `frontend: dev` 启动前端
4. 或直接选择 `dev: all` 并行启动前后端

当前脚本如下：

- [`/scripts/run-backend-dev.ps1`](d:/GitHub/huobao-drama/scripts/run-backend-dev.ps1)
- [`/scripts/run-frontend-dev.ps1`](d:/GitHub/huobao-drama/scripts/run-frontend-dev.ps1)

## 14. 当前机器上前端的推荐启动方式

由于当前环境里的 `npm.cmd` 包装层可能受到历史全局配置影响，前端开发环境推荐优先使用以下两种方式之一：

方式一：VS Code 任务

- `frontend: dev`
- `dev: all`

方式二：直接运行 Vite CLI

```powershell
& 'D:\Users\cao_l\AppData\Local\nvm\v20.16.0\node.exe' .\web\node_modules\vite\bin\vite.js
```

项目中也已将 npm 缓存目录收敛到 D 盘仓库目录：

- [`/web/.npmrc`](d:/GitHub/huobao-drama/web/.npmrc)
- [`/.npm-cache`](d:/GitHub/huobao-drama/.npm-cache)

## 15. Docker 和 CentOS 发布流程

当前仓库已提供完整的 Docker 构建与 CentOS 运行脚本。

核心文件：

- [`/Dockerfile`](d:/GitHub/huobao-drama/Dockerfile)
- [`/scripts/docker-build-backend-linux-artifact.ps1`](d:/GitHub/huobao-drama/scripts/docker-build-backend-linux-artifact.ps1)
- [`/scripts/docker-build-backend-linux-artifact.sh`](d:/GitHub/huobao-drama/scripts/docker-build-backend-linux-artifact.sh)
- [`/scripts/docker-build-image.ps1`](d:/GitHub/huobao-drama/scripts/docker-build-image.ps1)
- [`/scripts/docker-build-image.sh`](d:/GitHub/huobao-drama/scripts/docker-build-image.sh)
- [`/scripts/docker-run-centos.ps1`](d:/GitHub/huobao-drama/scripts/docker-run-centos.ps1)
- [`/scripts/docker-run-centos.sh`](d:/GitHub/huobao-drama/scripts/docker-run-centos.sh)

### 15.1 方案一：只导出 Linux 后端可执行文件

适合在本地或 CI 中用 Docker 统一编译，然后把生成的 Linux 二进制上传到 CentOS 服务器。

导出后的默认产物：

- [`/build/linux-amd64/huobao-drama-api`](d:/GitHub/huobao-drama/build/linux-amd64/huobao-drama-api)

Windows：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\docker-build-backend-linux-artifact.ps1
```

Linux：

```bash
chmod +x ./scripts/docker-build-backend-linux-artifact.sh
./scripts/docker-build-backend-linux-artifact.sh
```

### 15.2 方案二：构建完整运行镜像

Windows：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\docker-build-image.ps1
```

Linux：

```bash
chmod +x ./scripts/docker-build-image.sh
./scripts/docker-build-image.sh
```

默认镜像标签：

```text
huobao-drama:latest
```

### 15.3 直接运行容器

Windows：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\docker-run-centos.ps1
```

Linux / CentOS：

```bash
chmod +x ./scripts/docker-run-centos.sh
./scripts/docker-run-centos.sh
```

默认行为：

- 映射端口 `5678:5678`
- 挂载数据目录到 `/app/data`
- 挂载配置文件到 `/app/configs/config.yaml`
- 自动设置 `TZ=Asia/Shanghai`

### 15.4 只在 CentOS 上运行二进制

如果你不想跑容器，只想把 Linux 二进制上传到 CentOS 后直接运行，可使用：

- 启动脚本：[`/scripts/start-backend-centos.sh`](d:/GitHub/huobao-drama/scripts/start-backend-centos.sh)
- 停止脚本：[`/scripts/stop-backend-centos.sh`](d:/GitHub/huobao-drama/scripts/stop-backend-centos.sh)

CentOS 启动：

```bash
chmod +x ./scripts/start-backend-centos.sh ./scripts/stop-backend-centos.sh
./scripts/start-backend-centos.sh
```

CentOS 停止：

```bash
./scripts/stop-backend-centos.sh
```

## 16. Windows 和 CentOS 脚本清单

### 16.1 Windows 用这些

开发运行：

- [`/scripts/run-backend-dev.ps1`](d:/GitHub/huobao-drama/scripts/run-backend-dev.ps1)
- [`/scripts/run-frontend-dev.ps1`](d:/GitHub/huobao-drama/scripts/run-frontend-dev.ps1)

Linux 后端编译：

- [`/scripts/build-backend-linux.ps1`](d:/GitHub/huobao-drama/scripts/build-backend-linux.ps1)
- [`/scripts/docker-build-backend-linux-artifact.ps1`](d:/GitHub/huobao-drama/scripts/docker-build-backend-linux-artifact.ps1)

Docker 镜像与容器：

- [`/scripts/docker-build-image.ps1`](d:/GitHub/huobao-drama/scripts/docker-build-image.ps1)
- [`/scripts/docker-run-centos.ps1`](d:/GitHub/huobao-drama/scripts/docker-run-centos.ps1)

### 16.2 CentOS / Linux 用这些

本地 Linux 编译：

- [`/scripts/build-backend-linux.sh`](d:/GitHub/huobao-drama/scripts/build-backend-linux.sh)

Docker 导出 Linux 二进制：

- [`/scripts/docker-build-backend-linux-artifact.sh`](d:/GitHub/huobao-drama/scripts/docker-build-backend-linux-artifact.sh)

Docker 构建镜像与启动容器：

- [`/scripts/docker-build-image.sh`](d:/GitHub/huobao-drama/scripts/docker-build-image.sh)
- [`/scripts/docker-run-centos.sh`](d:/GitHub/huobao-drama/scripts/docker-run-centos.sh)

直接运行后端二进制：

- [`/scripts/start-backend-centos.sh`](d:/GitHub/huobao-drama/scripts/start-backend-centos.sh)
- [`/scripts/stop-backend-centos.sh`](d:/GitHub/huobao-drama/scripts/stop-backend-centos.sh)

### 16.3 最常用组合

Windows 本地开发：

- `backend: run`
- `frontend: dev`
- `dev: all`

Windows 构建 CentOS 产物：

- `build-backend-linux.ps1`
- `docker-build-backend-linux-artifact.ps1`
- `docker-build-image.ps1`

CentOS 服务器部署：

- `docker-run-centos.sh`
- 或 `start-backend-centos.sh`

## 17. Docker 环境变量

当前仓库已提供 Docker 环境变量模板：

- [`/.env.docker.example`](d:/GitHub/huobao-drama/.env.docker.example)

如需自定义 Docker Compose 运行参数，可复制为 `.env`：

```powershell
Copy-Item .\.env.docker.example .\.env
```

可配置项：

- `COMPOSE_PROJECT_NAME`
- `CONTAINER_NAME`
- `HOST_PORT`
- `TZ`

当前 [`/docker-compose.yml`](d:/GitHub/huobao-drama/docker-compose.yml) 已支持读取这些变量。
