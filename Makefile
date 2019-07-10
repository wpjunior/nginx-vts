build:
	docker build -t wpjunior/nginx-vts .

run:
	docker run -it -p 8000:8000 wpjunior/nginx-vts
