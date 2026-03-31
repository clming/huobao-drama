# Huobao Drama 安装与启动说明

本文档说明 `Huobao Drama` 项目在本地开发、Docker 运行、以及 CentOS/Linux 部署时的常用安装、编译和启动方法。

适用目录：
[`huobao-drama`](d:/GitHub/huobao-drama)

## 1. 项目依赖

本项目主要依赖以下工具：

- Go `1.23.x`
- Node.js `23.7.0`（本地开发）
- npm（随 Node.js 附带）
- FFmpeg（视频合成功能需要，本地开发可选，服务端部署必须）
- Docker（仅 Docker 部署时需要）

说明：

- 前端统一使用 `nvm` 管理 Node 版本。
- 当前推荐的 Go 路径：
  [`D:\Program Files\Go1.23.1`](d:/Program%20Files/Go1.23.1)
- 后续新增工具、缓存和构建产物，优先放在 `D:` 盘。
- 当前后端已切换为纯 Go 的 SQLite 驱动（`glebarez/sqlite`），**本地运行不再依赖 `gcc/cgo`**。

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
23.7.0
```

> **注意**：系统 PATH 中默认的 node 可能是其他版本（例如 v20.16.0）。每次操作前端之前，请先运行 `nvm use 23.7.0` 切换到正确版本。

安装并切换版本：

```powershell
nvm install 23.7.0
nvm use 23.7.0
node -v
npm -v
```

仓库内已提供版本约束：

- [`/.nvmrc`](d:/GitHub/huobao-drama/.nvmrc) — 内容为 `23.7.0`
- [`/web/.nvmrc`](d:/GitHub/huobao-drama/web/.nvmrc)
- [`/web/package.json`](d:/GitHub/huobao-drama/web/package.json) — engines 约束：`>=22.12.0 <24`

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

本项目的视频合成和剪辑功能依赖 `FFmpeg`。

> **说明**：如果只是做前端开发或剧本/分镜调试，不涉及视频合成，可以暂时跳过此步。视频合成功能（`video-merges` 接口）运行时才需要 FFmpeg。

### Windows 安装方式

1. 打开官网：`https://ffmpeg.org/download.html`
2. 下载 Windows 版本（推荐 essentials 版本即可）
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
nvm use 23.7.0
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

完整默认配置示例：

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
  read_timeout: 600        # 读超时（秒），默认 10 分钟
  write_timeout: 600       # 写超时（秒），默认 10 分钟

database:
  type: "sqlite"
  path: "./data/drama_generator.db"
  max_idle: 10
  max_open: 100

storage:
  type: "local"
  local_path: "./data/storage"
  base_url: "http://localhost:5678/static"

ai:
  default_text_provider: "openai"     # 文本/剧本生成 AI 提供商
  default_image_provider: "openai"    # 图片生成 AI 提供商
  default_video_provider: "doubao"    # 视频生成 AI 提供商（豆包）
```

配置说明：

| 配置项 | 说明 |
|---|---|
| `server.port` | 后端服务端口，默认 `5678` |
| `server.cors_origins` | CORS 允许的前端来源，开发模式需包含 `http://localhost:3012` |
| `server.read_timeout` / `write_timeout` | HTTP 超时（秒），AI 生成任务耗时较长，建议保持 600 |
| `database.type` | 数据库类型，当前仅支持 `sqlite` |
| `database.path` | SQLite 数据库文件路径 |
| `storage.local_path` | 本地文件存储路径（用于上传的图片、视频等素材） |
| `storage.base_url` | 静态文件访问的基础 URL |
| `ai.default_text_provider` | 默认文本 AI 提供商，启动后可在页面「AI 配置」中添加和切换 |
| `ai.default_image_provider` | 默认图片 AI 提供商 |
| `ai.default_video_provider` | 默认视频 AI 提供商（如豆包 Doubao、OpenAI Sora 等） |

## 7. 启动项目

### 7.1 开发模式启动（前后端分离）

推荐开发时使用前后端分离方式，需要**两个终端**。

**终端 1：启动 Go 后端**

推荐方式：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\run-backend-dev.ps1
```

或：

```powershell
.\scripts\run-backend-dev.cmd
```

**终端 2：启动前端**

推荐方式：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\run-frontend-dev.ps1
```

默认地址：

- 前端：`http://localhost:3012`（Vite 开发服务器，自动代理 `/api` 到后端）
- 后端 API：`http://localhost:5678/api/v1`
- 健康检查：`http://localhost:5678/health`

> **提示**：前端 Vite 配置（[`web/vite.config.ts`](d:/GitHub/huobao-drama/web/vite.config.ts)）已设置代理，开发模式下前端的 `/api` 请求会自动转发到 `http://localhost:5678`。

### 7.2 单服务模式启动

先构建前端，然后只启动后端（后端会自动托管前端静态文件）。

前端构建：

```powershell
nvm use 23.7.0
cd web
npm run build
cd ..
```

或直接使用 node 调用 Vite：

```powershell
& 'D:\Users\cao_l\AppData\Local\nvm\v23.7.0\node.exe' .\web\node_modules\vite\bin\vite.js build
```

后端启动：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\run-backend-dev.ps1
```

此模式下只需访问 `http://localhost:5678` 即可（前后端一体）。

## 8. 编译 Go 后端

验证后端能否编译：

```powershell
New-Item -ItemType Directory -Force -Path .\.gocache | Out-Null
$env:GOROOT='D:\Program Files\Go1.23.1'
$env:PATH='D:\Program Files\Go1.23.1\bin;' + $env:PATH
$env:GOTOOLCHAIN='local'
$env:GOTELEMETRY='off'
$env:GOCACHE=(Join-Path (Get-Location) '.gocache')
& 'D:\Program Files\Go1.23.1\bin\go.exe' build ./...
```

说明：

- 当前后端已切换为纯 Go SQLite 驱动（`glebarez/sqlite`）
- 本地运行不再依赖 `gcc/cgo`
- Windows 下 `CGO_ENABLED` 默认即可，不需要额外安装 C 编译器

## 9. 编译 Node 前端

当前机器上，推荐直接使用 `node + vite` 的方式构建前端：

```powershell
& 'D:\Users\cao_l\AppData\Local\nvm\v23.7.0\node.exe' .\web\node_modules\vite\bin\vite.js build
```

或通过 npm scripts：

```powershell
nvm use 23.7.0
cd web
npm run build
cd ..
```

产物目录：
[`web/dist`](d:/GitHub/huobao-drama/web/dist)

> **说明**：`package.json` 中的 `scripts` 已直接使用 `node ./node_modules/vite/bin/vite.js` 方式调用，不依赖全局安装的 vite CLI。

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

| 文件 | 说明 |
|---|---|
| [`Readme-install.md`](d:/GitHub/huobao-drama/Readme-install.md) | 本安装文档 |
| [`README.md`](d:/GitHub/huobao-drama/README.md) | 项目说明与功能介绍 |
| [`go.mod`](d:/GitHub/huobao-drama/go.mod) | Go 模块声明（Go 1.23.0） |
| [`main.go`](d:/GitHub/huobao-drama/main.go) | 后端入口 |
| [`configs/config.example.yaml`](d:/GitHub/huobao-drama/configs/config.example.yaml) | 配置模板 |
| [`configs/config.yaml`](d:/GitHub/huobao-drama/configs/config.yaml) | 实际配置文件（不入版本库） |
| [`web/package.json`](d:/GitHub/huobao-drama/web/package.json) | 前端依赖声明 |
| [`web/vite.config.ts`](d:/GitHub/huobao-drama/web/vite.config.ts) | Vite 配置（端口 3012，API 代理） |
| [`migrations/init.sql`](d:/GitHub/huobao-drama/migrations/init.sql) | 数据库初始化 SQL（仅参考，首次启动自动迁移） |

## 13. VS Code 一键启动

当前仓库已提供 VS Code 任务文件：
[`/.vscode/tasks.json`](d:/GitHub/huobao-drama/.vscode/tasks.json)

可直接在 VS Code 中使用：

1. 打开 `Terminal -> Run Task`
2. 选择 `backend: run` 启动后端
3. 选择 `frontend: dev` 启动前端
4. 或直接选择 `dev: all` 并行启动前后端

当前脚本如下：

- [`/scripts/run-backend-dev.ps1`](d:/GitHub/huobao-drama/scripts/run-backend-dev.ps1) — 设定 GOROOT 后执行 `go run main.go`
- [`/scripts/run-backend-dev.cmd`](d:/GitHub/huobao-drama/scripts/run-backend-dev.cmd) — CMD 包装，内部调用上述 ps1
- [`/scripts/run-frontend-dev.ps1`](d:/GitHub/huobao-drama/scripts/run-frontend-dev.ps1) — 设定 node 路径后执行 `vite` 开发服务器

## 14. 当前机器上前端的推荐启动方式

由于当前环境里的 `npm.cmd` 包装层可能受到历史全局配置影响，前端开发环境推荐优先使用以下两种方式之一：

方式一：VS Code 任务

- `frontend: dev`
- `dev: all`

方式二：直接运行 Vite CLI

```powershell
& 'D:\Users\cao_l\AppData\Local\nvm\v23.7.0\node.exe' .\web\node_modules\vite\bin\vite.js
```

项目中也已将 npm 缓存目录收敛到 D 盘仓库目录：

- [`/web/.npmrc`](d:/GitHub/huobao-drama/web/.npmrc) — 设定 `cache=../.npm-cache`
- [`/.npm-cache`](d:/GitHub/huobao-drama/.npm-cache)

## 15. Docker 和 CentOS 发布流程

当前仓库已提供完整的 Docker 构建与 CentOS 运行脚本。

> **注意**：Docker 镜像内部使用 `node:20` 构建前端、`golang:1.23` 编译后端，运行时基于 `rockylinux:9`。这与本地开发使用 Node 23.7.0 不冲突，Docker 构建是独立环境。

核心文件：

- [`/Dockerfile`](d:/GitHub/huobao-drama/Dockerfile) — 多阶段构建（前端 → 后端 → 运行时）
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
- [`/scripts/run-backend-dev.cmd`](d:/GitHub/huobao-drama/scripts/run-backend-dev.cmd)
- [`/scripts/run-frontend-dev.ps1`](d:/GitHub/huobao-drama/scripts/run-frontend-dev.ps1)

Linux 后端编译：

- [`/scripts/build-backend-linux.ps1`](d:/GitHub/huobao-drama/scripts/build-backend-linux.ps1) — 纯 Go 交叉编译（CGO_ENABLED=0）
- [`/scripts/docker-build-backend-linux-artifact.ps1`](d:/GitHub/huobao-drama/scripts/docker-build-backend-linux-artifact.ps1) — Docker 内编译

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

## 17. Docker Compose 运行方式

### 17.1 Docker 环境变量

当前仓库已提供 Docker 环境变量模板：

- [`/.env.docker.example`](d:/GitHub/huobao-drama/.env.docker.example)

如需自定义 Docker Compose 运行参数，可复制为 `.env`：

```powershell
Copy-Item .\.env.docker.example .\.env
```

可配置项：

| 变量名 | 默认值 | 说明 |
|---|---|---|
| `COMPOSE_PROJECT_NAME` | `huobao-drama` | Docker Compose 项目名 |
| `CONTAINER_NAME` | `huobao-drama` | 容器名称 |
| `HOST_PORT` | `5678` | 宿主机映射端口 |
| `TZ` | `Asia/Shanghai` | 容器时区 |

### 17.2 使用 Docker Compose 启动

```powershell
# 构建并启动
docker compose up -d --build

# 查看状态
docker compose ps

# 查看日志
docker compose logs -f

# 停止
docker compose down
```

当前 [`/docker-compose.yml`](d:/GitHub/huobao-drama/docker-compose.yml) 已支持读取上述环境变量。

Compose 文件内容：
- 使用 `Dockerfile` 多阶段构建镜像
- 挂载 `./data` 到 `/app/data`（数据持久化）
- 挂载 `./configs/config.yaml` 到 `/app/configs/config.yaml`（只读）
- 配置健康检查（每 30s 检查 `/health`）
- 设置 `restart: unless-stopped`

## 18. 数据库说明

- 数据库表会在**首次启动时自动创建**（使用 GORM AutoMigrate），无需手动执行 SQL。
- 参考 SQL 文件：[`migrations/init.sql`](d:/GitHub/huobao-drama/migrations/init.sql)
- 数据库文件位置：`./data/drama_generator.db`

数据库包含的主要表：

| 表名 | 说明 |
|---|---|
| `dramas` | 剧本（短剧项目） |
| `episodes` | 章节 |
| `characters` | 角色 |
| `scenes` | 场景 |
| `storyboards` | 分镜 |
| `image_generations` | 图片生成记录 |
| `video_generations` | 视频生成记录 |
| `video_merges` | 视频合成记录 |
| `assets` | 素材库 |
| `ai_configs` | AI 提供商配置 |
| `tasks` | 异步任务记录 |
