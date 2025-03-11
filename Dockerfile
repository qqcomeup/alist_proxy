# 基于 Python 3.12.8 的 Alpine 镜像
FROM python:3.12.8-alpine

# 设置工作目录
WORKDIR /app

# 安装构建依赖（包括必要的编译工具和库）
RUN apk add --no-cache --virtual .build-deps gcc musl-dev libxml2-dev libxslt-dev curl bash && \
    # 安装 Python 依赖
    pip install --no-cache-dir requests watchdog clouddrive lxml uncurl httpx[http2] beautifulsoup4 flaresolverr && \
    # 删除构建依赖
    apk del .build-deps

# 安装 cron 服务
RUN apk add --no-cache cron

# 将你的 Python 脚本和 cron 配置文件复制到容器中
COPY . /app

# 复制 cron 配置文件到系统 cron 配置目录
COPY crontab /etc/crontabs/root

# 设置容器启动时运行 cron 服务
CMD ["sh", "-c", "crond && tail -f /dev/null"]
