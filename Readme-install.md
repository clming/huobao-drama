# Huobao Drama 瀹夎涓庡惎鍔ㄨ鏄?
鏈枃妗ｇ敤浜庤鏄?`Huobao Drama` 椤圭洰鍦ㄦ湰鍦板紑鍙戠幆澧冧腑鐨勫畨瑁呮柟娉曚笌鍚姩鏂规硶銆?
閫傜敤鐩綍锛?[`huobao-drama`](d:/GitHub/huobao-drama)

## 1. 椤圭洰渚濊禆

鏈」鐩富瑕佷緷璧栦互涓嬪伐鍏凤細

- Go `1.23.x`
- Node.js `20.16.0`
- npm
- FFmpeg

璇存槑锛?
- 鍓嶇宸茬粺涓€浣跨敤 `nvm` 绠＄悊 Node 鐗堟湰銆?- 濡傛灉浣犳湰鏈哄凡缁忔湁鏃х増 Go锛屽彲浠ヤ繚鐣欏師鐗堟湰锛屽彧棰濆瀹夎涓€涓?`Go 1.23.x` 鐢ㄤ簬鏈」鐩€?
## 2. 瀹夎 Node.js 骞朵娇鐢?nvm 绠＄悊

### 2.1 瀹夎 nvm for Windows

濡傛灉鏈満杩樻病鏈夊畨瑁?`nvm`锛屽彲鍏堝畨瑁?`nvm-windows`锛?
1. 鎵撳紑鍙戝竷椤碉細`https://github.com/coreybutler/nvm-windows/releases`
2. 涓嬭浇骞跺畨瑁?`nvm-setup.exe`
3. 瀹夎瀹屾垚鍚庯紝閲嶆柊鎵撳紑缁堢

楠岃瘉鏄惁瀹夎鎴愬姛锛?
```powershell
nvm version
```

### 2.2 瀹夎椤圭洰鎵€闇€ Node 鐗堟湰

鏈」鐩粺涓€浣跨敤锛?
```text
20.16.0
```

瀹夎骞跺垏鎹㈢増鏈細

```powershell
nvm install 20.16.0
nvm use 20.16.0
node -v
npm -v
```

浠撳簱鍐呭凡娣诲姞鐗堟湰绾︽潫鏂囦欢锛?
- [`/.nvmrc`](d:/GitHub/huobao-drama/.nvmrc)
- [`/web/.nvmrc`](d:/GitHub/huobao-drama/web/.nvmrc)
- [`/web/package.json`](d:/GitHub/huobao-drama/web/package.json)

## 3. 瀹夎 Go 1.23锛屽苟淇濈暀鍘熸湁 Go 鐗堟湰

鏈」鐩殑 Go 鐗堟湰瑕佹眰瑙侊細
[`go.mod`](d:/GitHub/huobao-drama/go.mod)

褰撳墠瑕佹眰锛?
```text
go 1.23.0
```

濡傛灉浣犵數鑴戦噷宸茬粡瑁呬簡鏃х増 Go锛屼笉闇€瑕佸嵏杞姐€傚缓璁澶栧畨瑁呬竴涓?`Go 1.23.x`锛屼笓闂ㄧ敤浜庢湰椤圭洰銆?
### 3.1 瀹夎鏂瑰紡涓€锛氬畼鏂瑰畨瑁呭寘

1. 鎵撳紑 Go 瀹樻柟涓嬭浇椤碉細`https://go.dev/dl/`
2. 涓嬭浇 Windows `amd64` 鐨?`Go 1.23.x` 瀹夎鍖?3. 瀹夎鍒版柊鐨勭洰褰曪紝閬垮厤瑕嗙洊浣犲凡鏈夌幆澧?
寤鸿瀹夎鍚庢鏌ョ増鏈細

```powershell
go version
```

### 3.2 瀹夎鏂瑰紡浜岋細浣跨敤鐙珛 Go 璺緞

濡傛灉浣犲笇鏈涗繚鐣欓粯璁?Go 鐗堟湰锛屼篃鍙互鍗曠嫭涓嬭浇涓€浠?`Go 1.23.x`锛岃В鍘嬪埌渚嬪锛?
```text
D:\Program Files\Go1.23.1
```

鐒跺悗鍦ㄥ綋鍓嶉」鐩腑鏄惧紡浣跨敤璇ョ増鏈墽琛屽懡浠わ紝渚嬪锛?
```powershell
& 'D:\Program Files\Go1.23.1\bin\go.exe' version
& 'D:\Program Files\Go1.23.1\bin\go.exe' build ./...
```

杩欑鏂瑰紡涓嶄細褰卞搷浣犵郴缁熼噷鍘熸潵鐨?Go 鐗堟湰銆?
## 4. 瀹夎 FFmpeg

鏈」鐩殑瑙嗛澶勭悊渚濊禆 `FFmpeg`銆?
### Windows 瀹夎鏂瑰紡

1. 鎵撳紑瀹樼綉锛歚https://ffmpeg.org/download.html`
2. 涓嬭浇 Windows 鐗堟湰
3. 瑙ｅ帇鍚庡皢 `ffmpeg.exe` 鎵€鍦ㄧ洰褰曞姞鍏ョ郴缁?`PATH`

楠岃瘉锛?
```powershell
ffmpeg -version
```

## 5. 瀹夎椤圭洰渚濊禆

### 5.1 鍏嬮殕椤圭洰

```powershell
git clone https://github.com/chatfire-AI/huobao-drama.git
cd huobao-drama
```

### 5.2 瀹夎鍚庣渚濊禆

浣跨敤 Go `1.23.x`锛?
```powershell
go mod download
```

濡傛灉浣犱娇鐢ㄧ殑鏄嫭绔?Go 璺緞锛?
```powershell
& 'D:\Program Files\Go1.23.1\bin\go.exe' mod download
```

### 5.3 瀹夎鍓嶇渚濊禆

鍏堝垏鍒版纭?Node 鐗堟湰锛?
```powershell
nvm use 20.16.0
```

鐒跺悗瀹夎鍓嶇渚濊禆锛?
```powershell
cd web
npm install
cd ..
```

鍓嶇鐩綍锛?[`web`](d:/GitHub/huobao-drama/web)

## 6. 閰嶇疆椤圭洰

閰嶇疆妯℃澘鏂囦欢锛?[`configs/config.example.yaml`](d:/GitHub/huobao-drama/configs/config.example.yaml)

澶嶅埗涓哄疄闄呴厤缃枃浠讹細

```powershell
Copy-Item .\configs\config.example.yaml .\configs\config.yaml
```

鎴栦娇鐢細

```powershell
cp .\configs\config.example.yaml .\configs\config.yaml
```

鐢熸垚鍚庣殑閰嶇疆鏂囦欢璺緞锛?[`configs/config.yaml`](d:/GitHub/huobao-drama/configs/config.yaml)

榛樿閰嶇疆绀轰緥锛?
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

database:
  type: "sqlite"
  path: "./data/drama_generator.db"

storage:
  type: "local"
  local_path: "./data/storage"
  base_url: "http://localhost:5678/static"
```

## 7. 鍚姩椤圭洰

## 7.1 寮€鍙戞ā寮忓惎鍔?
鎺ㄨ崘寮€鍙戞椂浣跨敤鍓嶅悗绔垎绂绘柟寮忋€?
### 缁堢 1锛氬惎鍔?Go 鍚庣

濡傛灉榛樿 Go 宸茬粡鏄?`1.23.x`锛?
```powershell
go run main.go
```

濡傛灉浣犱娇鐢ㄧ殑鏄崟鐙畨瑁呯殑 Go `1.23.x`锛?
```powershell
& 'D:\Program Files\Go1.23.1\bin\go.exe' run .\main.go
```

鍚庣鍏ュ彛鏂囦欢锛?[`main.go`](d:/GitHub/huobao-drama/main.go)

### 缁堢 2锛氬惎鍔ㄥ墠绔?
```powershell
nvm use 20.16.0
cd web
npm run dev
```

鍚姩鍚庨粯璁よ闂湴鍧€锛?
- 鍓嶇锛歚http://localhost:3012`
- 鍚庣 API锛歚http://localhost:5678/api/v1`
- 鍋ュ悍妫€鏌ワ細`http://localhost:5678/health`

## 7.2 鍗曟湇鍔℃ā寮忓惎鍔?
濡傛灉浣犲笇鏈涘厛鏋勫缓鍓嶇锛屽啀鐢?Go 鍚庣缁熶竴鎻愪緵闈欐€佽祫婧愶紝鍙寜涓嬮潰鏂瑰紡鍚姩锛?
```powershell
nvm use 20.16.0
cd web
npm run build
cd ..
go run main.go
```

濡傛灉浣犱娇鐢ㄧ嫭绔?Go 璺緞锛?
```powershell
nvm use 20.16.0
cd web
npm run build
cd ..
& 'D:\Program Files\Go1.23.1\bin\go.exe' run .\main.go
```

## 8. 缂栬瘧 Go 鍚庣

濡傛灉浣犲彧鎯抽獙璇佸悗绔兘鍚︾紪璇戯紝鍙互鍦ㄩ」鐩牴鐩綍鎵ц锛?
```powershell
go build ./...
```

濡傛灉浣犱娇鐢ㄧ嫭绔?Go `1.23.x`锛?
```powershell
& 'D:\Program Files\Go1.23.1\bin\go.exe' build ./...
```

## 9. 甯歌妫€鏌ュ懡浠?
妫€鏌?Node 涓?npm锛?
```powershell
node -v
npm -v
```

妫€鏌?Go锛?
```powershell
go version
```

妫€鏌?FFmpeg锛?
```powershell
ffmpeg -version
```

## 10. VS Code 涓负椤圭洰鎸囧畾 Go 1.23

濡傛灉浣犲笇鏈涗繚鐣欑郴缁熼粯璁?Go 鐗堟湰锛屽悓鏃惰 VS Code 鍦ㄨ繖涓」鐩噷浣跨敤鍗曠嫭瀹夎鐨?`Go 1.23.x`锛屽彲浠ュ湪宸ヤ綔鍖鸿缃腑鎸囧畾 Go 璺緞銆?
渚嬪浣犵殑鐙珛 Go 瀹夎鍦細

```text
D:\Program Files\Go1.23.1
```

鍙互鍦ㄩ」鐩笅鏂板缓鎴栦慨鏀癸細

[`/.vscode/settings.json`](d:/GitHub/huobao-drama/.vscode/settings.json)

鍐欏叆锛?
```json
{
  "go.alternateTools": {
    "go": "D:\\Program Files\\Go1.23.1\\bin\\go.exe"
  }
}
```

濡傛灉浣犵殑 VS Code Go 鎻掍欢鐗堟湰鏇撮€傚悎鐩存帴璇诲彇鐜鍙橀噺锛屼篃鍙互杩欐牱鍐欙細

```json
{
  "go.toolsEnvVars": {
    "GOROOT": "D:\\Program Files\\Go1.23.1"
  }
}
```

寤鸿浜岄€変竴锛岄€氬父浼樺厛浣跨敤 `go.alternateTools`銆?
璁剧疆瀹屾垚鍚庡彲浠ュ湪 VS Code 缁堢涓獙璇侊細

```powershell
go version
```

濡傛灉缁堢浠嶇劧鏄剧ず鏃х増鏈紝鍙互鐩存帴鐢ㄥ畬鏁磋矾寰勯獙璇侊細

```powershell
& 'D:\Program Files\Go1.23.1\bin\go.exe' version
```

## 11. Windows 缁堢涓枃涔辩爜璇存槑

濡傛灉 Markdown 鏂囦欢鍦?PowerShell 閲屾樉绀轰贡鐮侊紝浣嗗湪 VS Code 缂栬緫鍣ㄤ腑鏄剧ず姝ｅ父锛岄€氬父涓嶆槸鏂囦欢鎹熷潖锛岃€屾槸缁堢缂栫爜闂銆?
鍙互鍏堝湪褰撳墠缁堢鎵ц锛?
```powershell
chcp 65001
[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
```

鐒跺悗鍐嶆煡鐪嬫枃浠讹細

```powershell
Get-Content README.md
Get-Content Readme-install.md
```

濡傛灉浣犲笇鏈?PowerShell 7 闀挎湡浣跨敤 UTF-8锛屽彲鍦?PowerShell 閰嶇疆鏂囦欢涓姞鍏ョ浉鍚岃缃€?
## 12. 褰撳墠浠撳簱涓殑鍏抽敭鏂囦欢

- 瀹夎鏂囨。锛歔`Readme-install.md`](d:/GitHub/huobao-drama/Readme-install.md)
- 椤圭洰璇存槑锛歔`README.md`](d:/GitHub/huobao-drama/README.md)
- Go 妯″潡澹版槑锛歔`go.mod`](d:/GitHub/huobao-drama/go.mod)
- 鍚庣鍏ュ彛锛歔`main.go`](d:/GitHub/huobao-drama/main.go)
- 閰嶇疆妯℃澘锛歔`configs/config.example.yaml`](d:/GitHub/huobao-drama/configs/config.example.yaml)
- 鍓嶇鐗堟湰澹版槑锛歔`web/package.json`](d:/GitHub/huobao-drama/web/package.json)


## 13. VS Code 一键启动

当前仓库已提供 VS Code 任务文件：
[`/.vscode/tasks.json`](d:/GitHub/huobao-drama/.vscode/tasks.json)

可直接在 VS Code 中使用：

1. 打开 `Terminal -> Run Task`
2. 选择 `backend: run` 启动后端
3. 选择 `frontend: dev` 启动前端
4. 或直接选择 `dev: all` 并行启动前后端

前端任务当前通过下面的脚本启动：
[`/scripts/run-frontend-dev.ps1`](d:/GitHub/huobao-drama/scripts/run-frontend-dev.ps1)

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

这个方案适合你在本地或 CI 中用 Docker 统一编译，然后把生成的 Linux 二进制上传到 CentOS 服务器。

导出后的默认产物：
- [`/build/linux-amd64/huobao-drama-api`](d:/GitHub/huobao-drama/build/linux-amd64/huobao-drama-api)

Windows 执行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\docker-build-backend-linux-artifact.ps1
```

Linux 执行：

```bash
chmod +x ./scripts/docker-build-backend-linux-artifact.sh
./scripts/docker-build-backend-linux-artifact.sh
```

### 15.2 方案二：构建完整运行镜像

这个方案会同时构建前端和后端，并生成可直接运行的容器镜像。

Windows 执行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\docker-build-image.ps1
```

Linux 执行：

```bash
chmod +x ./scripts/docker-build-image.sh
./scripts/docker-build-image.sh
```

默认镜像标签：

```text
huobao-drama:latest
```

### 15.3 直接运行容器

Windows 执行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\docker-run-centos.ps1
```

Linux / CentOS 执行：

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
