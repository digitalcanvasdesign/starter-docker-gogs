FROM nginx:latest

LABEL maintainer="Jason Raimondi <jason@raimondi.us>"

RUN mkdir -p /etc/letsencrypt/webrootauth \
    && rm -rf /etc/nginx/conf.d

COPY conf.d/ /etc/nginx/conf.d
COPY include/ /etc/nginx/include
COPY nginx.conf /etc/nginx/nginx.conf
COPY dhparam.pem /etc/nginx/ssl/dhparam.pem

