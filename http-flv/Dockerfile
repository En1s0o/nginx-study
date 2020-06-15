FROM build_env:latest
MAINTAINER Eniso

ADD perl-5.30.3.tar.gz /tmp
ADD nginx-1.18.0.tar.gz /tmp
ADD openssl-1.1.1g.tar.gz /tmp
ADD pcre-8.44.tar.gz /tmp
ADD zlib-1.2.11.tar.gz /tmp
ADD nginx-goodies-nginx-sticky-module-ng-08a395c66e42.tar.gz /tmp
ADD nginx-http-flv-module.tar.gz /tmp

ENV NGINX_TMEP_PATH=/var/lib/nginx/temp
RUN mkdir -p ${NGINX_TMEP_PATH}
RUN adduser nginx

RUN cd /tmp/perl-5.30.3 \
    && ./Configure -des \
    && make && make install

RUN cd /tmp/nginx-1.18.0 \
    && ./configure \
        --prefix=/etc/nginx \
        --sbin-path=/usr/sbin/nginx \
        --modules-path=/usr/lib/nginx/modules \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/run/nginx.lock \
        --http-client-body-temp-path=${NGINX_TMEP_PATH}/client_body \
        --http-proxy-temp-path=${NGINX_TMEP_PATH}/proxy \
        --http-fastcgi-temp-path=${NGINX_TMEP_PATH}/fastcgi \
        --http-uwsgi-temp-path=${NGINX_TMEP_PATH}/uwsgi \
        --http-scgi-temp-path=${NGINX_TMEP_PATH}/scgi \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/run/nginx.lock \
        --user=nginx \
        --group=nginx \
        --with-compat \
        --with-file-aio \
        --with-threads \
        --with-http_addition_module \
        --with-http_auth_request_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_mp4_module \
        --with-http_random_index_module \
        --with-http_realip_module \
        --with-http_secure_link_module \
        --with-http_slice_module \
        --with-http_ssl_module \
        --with-http_stub_status_module \
        --with-http_sub_module \
        --with-http_v2_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-stream \
        --with-stream_realip_module \
        --with-stream_ssl_module \
        --with-stream_ssl_preread_module \
        --with-openssl=/tmp/openssl-1.1.1g \
        --with-openssl-opt=-fPIC \
        --with-pcre=/tmp/pcre-8.44 \
        --with-pcre-opt=-fPIC \
        --with-zlib=/tmp/zlib-1.2.11 \
        --with-zlib-opt=-fPIC \
        --add-module=/tmp/nginx-goodies-nginx-sticky-module-ng-08a395c66e42 \
        --add-module=/tmp/nginx-http-flv-module \
        --with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -ftrapv -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' \
        --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro,-z,now -Wl,--as-needed -pie' \
    && make && make install

RUN yum clean headers \
    && yum clean packages \
    && yum clean metadata

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
