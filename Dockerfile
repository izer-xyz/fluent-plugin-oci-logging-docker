FROM fluentd:v1.9-debian-1

USER root

RUN buildDeps="sudo make gcc g++ libc-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && gem install fluent-plugin-oci-logging \
 && gem install fluent-plugin-systemd \
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem
 
# this assumes host GID 190 for journal access
RUN mkdir -p /var/log/journal \
 && chown fluent:fluent /var/log/journal \
 && addgroup -o -gid 190 systemd-journal \
 && usermod -a -G systemd-journal fluent 

COPY fluent.conf /fluentd/etc/
#COPY entrypoint.sh /bin/

USER fluent

EXPOSE 127.0.0.1::24224
