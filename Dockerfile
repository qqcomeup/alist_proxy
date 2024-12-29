# 使用官方的 Python 镜像作为基础镜像
FROM python:3.12

# 安装 OpenSSH 服务
RUN apt-get update && apt-get install -y openssh-server

# 设置容器的工作目录
WORKDIR /app

# 安装 pip 和更新
RUN pip install --upgrade pip

# 安装 alist_proxy
RUN pip install -U alist_proxy

# 创建 SSH 目录和配置文件
RUN mkdir /var/run/sshd

# 设置密码（可根据需要修改）
RUN echo 'root:password' | chpasswd

# 配置 SSH 服务
RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 暴露 SSH 和 alist_proxy 默认的端口
EXPOSE 22 5245

# 设置默认的环境变量，用于反代地址和端口
ENV HOST="0.0.0.0"
ENV PORT="5245"
ENV BASE_URL="http://localhost:5244"
# 例如使用 SQLite 数据库
ENV DB_URI sqlite:///app.db
# 如果需要 token 可以在此设置
ENV TOKEN="your-alist-token"

# 设置容器启动时的命令，启动 SSH 服务和 alist-proxy
CMD service ssh start && alist-proxy --token "alist-45b225f5-d6b1-4c29-8bb9-c352e6faa655HEhxRY1a4HeV9TLPEbdMJc61wbI0hB9tA3XXYmdEsPkErBmppiLuOJjo2ietr1Z1Z" --base-url "http://192.168.8.4:5244"

