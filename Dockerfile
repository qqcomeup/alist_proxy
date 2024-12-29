# 使用官方的 Python 镜像作为基础镜像
FROM python:3.9-slim

# 设置容器的工作目录
WORKDIR /app

# 安装 python-alist 的正确版本
RUN pip install python-alist>=0.0.13 -i https://pypi.tuna.tsinghua.edu.cn/simple

# 更新 pip
RUN pip install --upgrade pip

# 安装 alist-proxy，并禁用缓存
RUN pip install -U alist-proxy -i https://pypi.tuna.tsinghua.edu.cn/simple --no-cache-dir

# 暴露端口 5245
EXPOSE 5245

# 设置容器启动时的命令
CMD ["alist_proxy", "--port", "5245"]
