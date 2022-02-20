FROM alpine:latest
RUN apk add --no-cache linux-lts
RUN ln -s /boot/vmlinuz-lts /boot/vmlinuz && \
    ln -s /boot/initramfs-lts /boot/initrd.img
RUN echo "root:root" | chpasswd