# 基于 Python 3.12.8 的 Alpine 镜像
FROM python:3.12.8-alpine

# 设置工作目录
WORKDIR /app

# 安装 Python 依赖
RUN apk add --no-cache --virtual .build-deps gcc musl-dev && \
    pip install --no-cache-dir requests watchdog clouddrive && \
    apk del .build-deps

# 可选：将你的 Python 脚本或代码复制到工作目录
# COPY . /app

# 可选：设置默认运行的命令
# CMD ["python", "your_script.py"]
