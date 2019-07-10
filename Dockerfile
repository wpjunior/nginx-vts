FROM ubuntu:18.04

RUN apt update && apt install -y wget build-essential

RUN wget http://nginx.org/download/nginx-1.15.12.tar.gz
RUN tar -zxvf nginx-1.15.12.tar.gz
RUN mv nginx-1.15.12 nginx
RUN rm -Rf nginx-1.15.12.tar.gz

RUN wget https://github.com/vozlt/nginx-module-vts/archive/v0.1.18.tar.gz
RUN tar -zxvf v0.1.18.tar.gz
RUN rm -Rf v0.1.18.tar.gz
RUN mv nginx-module-vts-0.1.18/ nginx

RUN apt install -y libpcre3-dev zlib1g-dev
RUN cd nginx && ./configure --prefix=/usr --with-compat --add-dynamic-module=./nginx-module-vts-0.1.18
RUN cd nginx && make modules
RUN cd nginx && make install

ADD nginx.conf /etc/nginx.conf
EXPOSE 8000
ENTRYPOINT nginx -c /etc/nginx.conf