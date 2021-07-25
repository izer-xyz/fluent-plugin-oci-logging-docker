FROM fluent/fluentd

USER root

RUN sudo gem install fluent-plugin-oci-logging \
 && sudo gem sources --clear-all \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/
#COPY entrypoint.sh /bin/

USER fluent

EXPOSE 127.0.0.1::24224
