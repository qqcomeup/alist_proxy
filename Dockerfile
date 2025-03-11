# 基于 Python 3.12.8 的 Alpine 镜像
FROM python:3.12.8-alpine

# 设置工作目录
WORKDIR /app

# 更新包索引并安装构建依赖
RUN apk update && \
    apk add --no-cache --virtual .build-deps gcc musl-dev libxml2-dev libxslt-dev curl bash libcurl

# 安装 Python 依赖
RUN pip install --no-cache-dir requests watchdog clouddrive lxml uncurl httpx beautifulsoup4 -i https://pypi.tuna.tsinghua.edu.cn/simple

# 如果 flaresolverr 是自定义库，从源代码安装
# RUN pip install --no-cache-dir git+https://github.com/your-repo/flaresolverr.git

# 删除构建依赖
RUN apk del .build-deps

# 安装 cron 服务
RUN apk add --no-cache cron

# 将你的 Python 脚本和 cron 配置文件复制到容器中
COPY . /app

# 复制 cron 配置文件到系统 cron 配置目录
COPY crontab /etc/crontabs/root

# 设置容器启动时运行 cron 服务
CMD ["sh", "-c", "crond && tail -f /dev/null"]
