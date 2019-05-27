nginx:
	wget http://nginx.org/download/nginx-1.15.12.tar.gz
	tar -zxvf nginx-1.15.12.tar.gz
	mv nginx-1.15.12 nginx
	rm -Rf nginx-1.15.12.tar.gz

nginx-vts: nginx
	wget https://github.com/vozlt/nginx-module-vts/archive/v0.1.18.tar.gz
	tar -zxvf v0.1.18.tar.gz
	rm -Rf v0.1.18.tar.gz
	- mv nginx-module-vts-0.1.18/ nginx

build: nginx-vts
	cd nginx && ./configure --prefix=/tmp/nginx --with-compat --add-module=./nginx-module-vts-0.1.18
	cd nginx && make modules
	cd nginx && make

run:
	./nginx/objs/nginx -c ${PWD}/nginx.conf
