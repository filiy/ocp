FROM registry.access.redhat.com/rhscl/httpd-24-rhel7

ENV SCALE_SERVICE_HOST=hello-world-lab1.apps.ocp4.example.com
ENV SCALE_SERVICE_PORT=443
ENV REQUESTS=50000000
ENV CONCURRENCY=20

CMD ab -dSrk -c ${CONCURRENCY} -n ${REQUESTS} http://${SCALE_SERVICE_HOST}:${SCALE_SERVICE_PORT}/index.php