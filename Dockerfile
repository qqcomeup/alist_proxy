FROM python:3.12.8-alpine

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apk update && apk add --no-cache gcc musl-dev libffi-dev libmagic supervisor

# 安装 pip 并升级
RUN pip install --upgrade pip

# 安装 alist_proxy 和 python-emby-proxy
RUN pip install -U alist_proxy python-emby-proxy

# 创建 supervisor 配置目录
RUN mkdir -p /etc/supervisor/conf.d

# 复制 supervisord 配置文件到容器内
COPY ./config/supervisord.conf /etc/supervisor/supervisord.conf

# 暴露需要的端口
EXPOSE 5245 8096

# 设置默认的环境变量（根据需要修改）
ENV HOST=0.0.0.0
ENV PORT=5245
ENV BASE_URL=http://localhost:5244
ENV DB_URI=sqlite:///app.db
ENV TOKEN=your-alist-token
ENV EMBY_URL=http://localhost:8096

# 使用 supervisor 启动进程
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
