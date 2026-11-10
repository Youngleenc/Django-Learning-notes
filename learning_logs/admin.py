from django.contrib import admin
from .models import Topic
from .models import Topic,Entry
# 导入你的 Topic 模型

# 将 Topic 模型注册到 admin 后台
admin.site.register(Topic)
admin.site.register(Entry)
# Register your models here.
