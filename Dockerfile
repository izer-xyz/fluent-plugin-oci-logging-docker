FROM fluentd

USER root

RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && gem install fluent-plugin-oci-logging \
 && gem install fluent-plugin-systemd \
 && gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/
#COPY entrypoint.sh /bin/

USER fluent

EXPOSE 127.0.0.1::24224
