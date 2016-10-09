#FROM 指令指定基础镜像
#比较常用的基础镜像有ubuntu，centos。这里使用了一个nginx镜像
FROM nginx

#MAINTAINER指令用于将镜像制作者相关的信息写入到镜像中
#您可以将您的信息填入name以及email
MAINTAINER v4if <karma_wjc@yeah.net>

#配置Nginx，并设置在标准输出流输出日志（这样执行容器时才会看到日志）
RUN sed -i "s#root   html;#root   /usr/share/nginx/html;#g" /etc/nginx/nginx.conf

#Nginx日志输出到文件
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

#COPY指令复制主机的文件到镜像中 （在这里当前路径就是repo根目录）
#将项目的所有文件加入到Nginx静态资源目录里
COPY . /usr/share/nginx/html

#EXPOSE：指定容器监听的端口
EXPOSE 80

#CMD指令，容器启动时执行的命令
#启动Nginx并使其保持在前台运行
#CMD一般是保持运行的前台命令，命令退出时容器也会退出
CMD ["nginx", "-g", "pid /tmp/nginx.pid; daemon off;"]
