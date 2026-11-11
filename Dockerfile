# 使用官方 Python 3.10 精简版镜像
FROM python:3.10-slim

# 设置环境变量，防止 Python 写 pyc 文件，并让输出直接打印到终端
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 设置工作目录
WORKDIR /app

# 先只复制依赖文件，利用 Docker 缓存层加速后续构建
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目所有代码到容器中
COPY . .

# 收集静态文件（如果有静态文件需要处理）
RUN python manage.py collectstatic --noinput

# 暴露容器的 8000 端口
EXPOSE 8000

# 启动 Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "ll_project.wsgi:application"]
