#!/bin/bash

mkdir -p tmp
tar -xvf nginx-1.18.0.tar.gz -C tmp
tar -xvf openssl-1.1.1g.tar.gz -C tmp
tar -xvf zlib-1.2.11.tar.gz -C tmp
tar -xvf nginx-rtmp-module-1.2.1.tar.gz -C tmp
tar -xvf pcre-8.44.tar.gz -C tmp

cd tmp/nginx-1.18.0 && \
./configure --prefix=.. --with-zlib=../zlib-1.2.11 --with-pcre=../pcre-8.44 --with-openssl=../openssl-1.1.1g --with-http_ssl_module --add-module=../nginx-rtmp-module-1.2.1 && \
make -j32 && \
make install
cd ../../

mkdir nginx-out
mv tmp/conf nginx-out/
mv tmp/html nginx-out/
mv tmp/logs nginx-out/
mv tmp/sbin nginx-out/ 
tar -czvf nginx-out.tar.gz nginx-out
rm -rf tmp nginx-out

# 常用配置参数 configure arguments:
# --prefix=/etc/nginx
# --sbin-path=/usr/sbin/nginx
# --modules-path=/usr/lib/nginx/modules
# --conf-path=/etc/nginx/nginx.conf
# --error-log-path=/var/log/nginx/error.log
# --http-log-path=/var/log/nginx/access.log
# --pid-path=/var/run/nginx.pid
# --lock-path=/var/run/nginx.lock
# --http-client-body-temp-path=/var/cache/nginx/client_temp
# --http-proxy-temp-path=/var/cache/nginx/proxy_temp
# --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp
# --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp
# --http-scgi-temp-path=/var/cache/nginx/scgi_temp
# --user=nginx
# --group=nginx
# --with-compat
# --with-file-aio
# --with-threads
# --with-http_addition_module
# --with-http_auth_request_module
# --with-http_dav_module
# --with-http_flv_module
# --with-http_gunzip_module
# --with-http_gzip_static_module
# --with-http_mp4_module
# --with-http_random_index_module
# --with-http_realip_module
# --with-http_secure_link_module
# --with-http_slice_module
# --with-http_ssl_module
# --with-http_stub_status_module
# --with-http_sub_module
# --with-http_v2_module
# --with-mail
# --with-mail_ssl_module
# --with-stream
# --with-stream_realip_module
# --with-stream_ssl_module
# --with-stream_ssl_preread_module
# --with-cc-opt='-g -O2 -fdebug-prefix-map=/data/builder/debuild/nginx-1.14.2/debian/debuild-base/nginx-1.14.2=. -specs=/usr/share/dpkg/no-pie-compile.specs -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC'
# --with-ld-opt='-specs=/usr/share/dpkg/no-pie-link.specs -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie'
