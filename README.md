# fluentd-oci-logger-docker
Fluentd Docker container with OCI output plugin

 * https://github.com/fluent/fluentd-docker-image
 * https://github.com/oracle/fluent-plugin-oci-logging
 * https://docs.fluentd.org/container-deployment/docker-logging-driver
 * https://github.com/docker/build-push-action/blob/master/docs/advanced/push-multi-registries.md

Sample docker-compose.yml:
```
version: "3"
services:
  something:
    image: something
    ports:
      - "80:80"
    logging:
      driver: "fluentd"
      options:
        fluentd-async: "true"
        

  fluentd:
    image: ghcr.io/izer-xyz/oci-logger:latest
    environment:
      - ORACLE_LOG_OBJECT_ID=ocid.log....
    ports:
      - "127.0.0.1::24224"
      - "120.0.0.1::24224/udp"
 ```
