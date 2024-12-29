# 使用官方的 Python 精简版镜像
FROM python:3.12-slim-bullseye

# 安装 OpenSSH 服务、清理 apt 缓存并安装 alist_proxy
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -U alist_proxy

# 设置容器的工作目录
WORKDIR /app

# 创建 SSH 目录和配置文件
RUN mkdir /var/run/sshd

# 设置密码（可根据需要修改）
RUN echo 'root:password' | chpasswd

# 配置 SSH 服务
RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 设置时区为中国区（Asia/Shanghai）
ENV TZ=Asia/Shanghai

# 暴露 SSH 和 alist_proxy 默认的端口
EXPOSE 22 5245

# 设置默认的环境变量，用于反代地址和端口
ENV HOST=0.0.0.0
ENV PORT=5245
ENV BASE_URL=http://localhost:5244
ENV DB_URI=sqlite:///app.db
ENV TOKEN=your-alist-token

# 启动 SSH 服务和 alist-proxy
CMD service ssh start && alist-proxy --token $TOKEN --base-url $BASE_URL
