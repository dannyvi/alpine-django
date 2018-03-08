FROM registry.docker-cn.com/library/alpine:3.5
COPY . /target-dir
WORKDIR /target-dir
RUN sed -i 's/dl-cdn.alpinelinux.org/mirror.tuna.tsinghua.edu.cn/g' /etc/apk/repositories &&\
apk add --no-cache python3 && \
apk add --no-cache --virtual=build-dependencies \
    mariadb-dev\
    g++ \
    build-base libffi-dev python3-dev \
    libffi openssl ca-certificates \
    jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev \
    linux-headers pcre-dev  && \
pip3 install --upgrade pip  --no-cache-dir -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com &&\
pip3 install --no-cache-dir -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com -r /target-dir/requirements.txt && \
apk del g++ mariadb-dev && \
apk add --no-cache mariadb-client-libs && \
apk del --purge \
build-dependencies && \
rm -rf \
/root/.cache \
/tmp/*
