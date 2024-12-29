# 使用官方的 Python 镜像作为基础镜像
FROM python:3.9-slim

# 设置容器的工作目录
WORKDIR /app

# 更新 pip 和安装 alist_proxy
RUN pip install --upgrade pip
RUN pip install -U alist_proxy -i https://pypi.tuna.tsinghua.edu.cn/simple

# 暴露 alist_proxy 默认的端口
EXPOSE 5245

# 设置容器启动时的命令
CMD ["alist_proxy", "--help"]
