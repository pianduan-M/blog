# 
FROM nginx:1.23.3-alpine
# 署名
MAINTAINER pianduan 'pianduan95@gmail.com'
WORKDIR /app

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
RUN apk update

# 安装 git
RUN apk add git
# 安装 node
RUN apk add nodejs && apk add npm

# 设置 node 阿里镜像
# RUN npm config set registry https://registry.npm.taobao.org

# clone 项目
RUN git clone https://github.com/pianduan-M/blog.git
# 打包项目
RUN cd ./blog  && \
    npm install  && \
    npm run build

# nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 80 8080

CMD nginx -g 'daemon off;' && \
    node /app/blog/autoBuild.js
RUN echo "🎉 架 🎉 设 🎉 成 🎉 功 🎉"
