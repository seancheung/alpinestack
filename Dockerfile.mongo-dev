FROM seancheung/alpinestack:mongo
LABEL maintainer="Sean Cheung <theoxuanx@gmail.com>"

ARG CN_MIRROR=false
RUN if [ "$CN_MIRROR" = true ]; then \
		sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
		&& echo 'registry=https://registry.npm.taobao.org' > /root/.npmrc \
	; fi

RUN set -x \
    && echo "Install Dependencies..." \
	&& apk add --no-cache supervisor nodejs nodejs-npm \
	&& apk add --no-cache --virtual TMP python make g++ \
	&& npm -g i --unsafe-perm mongo-express \
	&& mkdir -p /etc/supervisor/conf.d \
	&& apk del TMP

COPY supervisord.conf /etc/
COPY supervisor/mongodb.conf /etc/supervisor/conf.d/
COPY supervisor-dev/mongo-express.conf /etc/supervisor/conf.d/

VOLUME ["/etc/supervisor/conf.d"]
EXPOSE 8082

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]