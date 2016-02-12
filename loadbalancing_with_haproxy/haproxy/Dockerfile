FROM haproxy

ADD haproxy.cfg /etc/haproxy/haproxy.cfg
ADD start.bash /haproxy-start
RUN chmod +x /haproxy-start

VOLUME ["/haproxy-override"]

WORKDIR /etc/haproxy

CMD ["bash", "/haproxy-start"]

EXPOSE 80
EXPOSE 443
