FROM alpine:latest
RUN apk add --no-cache parted udev coreutils
COPY new-disk.sh /new-disk.sh
ENTRYPOINT ["/bin/sh"]
CMD ["/new-disk.sh"]