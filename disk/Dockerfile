FROM alpine:latest
RUN apk add --no-cache parted udev coreutils dosfstools mtools e2fsprogs
COPY new-disk.sh /new-disk.sh
ENTRYPOINT ["/bin/sh"]
CMD ["/new-disk.sh"]