# 使用官方的 Python 镜像作为基础镜像
FROM python:3.9-slim

# 设置容器的工作目录
WORKDIR /app

# 安装 pip 和更新
RUN pip install --upgrade pip

# 安装 alist_proxy
RUN pip install -U alist_proxy

# 暴露 alist_proxy 默认的端口
EXPOSE 5245

# 设置容器启动时的命令
CMD ["alist_proxy", "--help"]
