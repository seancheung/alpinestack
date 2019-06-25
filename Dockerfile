FROM alpine:3.10
LABEL maintainer="Sean Cheung <theoxuanx@gmail.com>"

ARG CN_MIRROR=false
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.9/main' >> /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.9/community' >> /etc/apk/repositories
RUN if [ "$CN_MIRROR" = true ]; then sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; fi

RUN set -x \
    && echo "Install Dependencies..." \
	&& apk add --no-cache mysql redis mongodb bash supervisor \
	&& for path in \
		/var/run/mysql \
		/var/log/mysql \
		/var/opt/mysql \
	; do \
	mkdir -p "$path"; \
    chown mysql:mysql "$path"; \
	done \
    && for path in \
		/var/run/redis \
		/var/log/redis \
		/var/opt/redis \
	; do \
	mkdir -p "$path"; \
    chown redis:redis "$path"; \
	done \
    && for path in \
		/var/run/mongodb \
		/var/log/mongodb \
		/var/opt/mongodb \
	; do \
	mkdir -p "$path"; \
    chown mongodb:mongodb "$path"; \
	done \
	&& mkdir -p /etc/supervisor/conf.d

COPY my.cnf /etc/my.cnf
COPY redis.conf /etc/redis.conf
COPY mongod.conf /etc/mongod.conf
COPY supervisord.conf /etc/
COPY supervisor /etc/supervisor/conf.d/
COPY mysql.sh /entrypoint.sh

VOLUME ["/var/opt/mysql", "/var/opt/redis", "/var/opt/mongodb", "/etc/supervisor/conf.d"]
EXPOSE 3306 6379 27017

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]