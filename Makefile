default: install

install: copy-environment generate-dhparam pull build start generate-ssl-cert

copy-environment:
	cp -n .env.sample .env

generate-dhparam:
	docker run -ti -v nginx-ssl:/certs digitalcanvasdesign/openssl dhparam -out /certs/dhparam.pem 2048

generate-ssl-cert:
	mkdir -p data/letsencrypt/webrootauth
	docker run -ti --volumes-from dockergogs_nginx_1 certbot/certbot certonly --webroot -w /etc/letsencrypt/webrootauth -d YOUR_DOMAIN --email YOUR_EMAIL --agree-tos

reload-nginx:
	docker-compose kill -s HUP nginx

build:
	docker-compose build

clean: stop
	docker-compose rm

down:
	docker-compose down

pull:
	docker-compose pull

rebuild: down pull build start-force-recreate

restart: stop start

start:
	docker-compose up -d
	docker-compose ps

start-force-recreate:
	docker-compose up -d --force-recreate
	docker-compose ps

stats:
	docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}" --no-stream

stats-stream:
	docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}"

status:
	docker-compose ps

stop:
	docker-compose stop

tail:
	docker-compose logs -f

top:
	docker-compose top


.PHONY: install copy-environment generate-dhparam generate-ssl-cert reload-nginx build clean down pull rebuild restart start start-force-recreate stats stats-stream status stop tail top
