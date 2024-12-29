# 使用官方的 Python 镜像作为基础镜像
FROM python:3.12

# 设置容器的工作目录
WORKDIR /app

# 安装 pip 和更新
RUN pip install --upgrade pip

# 安装 alist_proxy
RUN pip install -U alist_proxy

# 暴露 alist_proxy 默认的端口
EXPOSE 5245

# 设置默认的环境变量，用于反代地址和端口
ENV HOST="0.0.0.0"
ENV PORT="5245"
ENV BASE_URL="http://localhost:5244"
# 例如使用 SQLite 数据库
ENV DB_URI sqlite:///app.db
# 如果需要 token 可以在此设置
ENV TOKEN="your-alist-token"  

# 设置容器启动时的命令，使用传入的环境变量
CMD ["alist-proxy", "-H", "${HOST}", "-P", "${PORT}", "-b", "${BASE_URL}", "-t", "${TOKEN}", "-u", "${DB_URI}"]
