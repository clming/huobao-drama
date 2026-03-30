# syntax=docker/dockerfile:1.7

FROM node:20-bookworm-slim AS frontend-builder

WORKDIR /app/web

COPY web/package*.json ./
RUN npm install

COPY web/ ./
RUN npm run build


FROM golang:1.23-bookworm AS backend-builder

ENV GOPROXY=https://proxy.golang.org,direct \
    GO111MODULE=on

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    pkg-config \
    libsqlite3-dev \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
COPY --from=frontend-builder /app/web/dist ./web/dist

RUN CGO_ENABLED=1 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags="-s -w" -o /app/build/linux-amd64/huobao-drama-api ./main.go


FROM scratch AS backend-artifact
COPY --from=backend-builder /app/build/linux-amd64/huobao-drama-api /huobao-drama-api


FROM rockylinux:9 AS runtime

RUN dnf install -y \
    ca-certificates \
    tzdata \
    ffmpeg \
    sqlite-libs \
    curl \
    && dnf clean all

ENV TZ=Asia/Shanghai

WORKDIR /app

COPY --from=backend-builder /app/build/linux-amd64/huobao-drama-api ./huobao-drama-api
COPY --from=frontend-builder /app/web/dist ./web/dist
COPY configs/config.example.yaml ./configs/config.example.yaml
COPY migrations ./migrations

RUN mkdir -p /app/data/storage && \
    cp ./configs/config.example.yaml ./configs/config.yaml && \
    chmod +x ./huobao-drama-api

EXPOSE 5678

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -fsS http://localhost:5678/health >/dev/null || exit 1

CMD ["./huobao-drama-api"]
