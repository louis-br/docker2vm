FROM alpine:latest
RUN apk add --no-cache grub grub-efi
WORKDIR /out/EFI/BOOT
RUN echo 'configfile ${cmdpath}/grub.cfg' > /tmp/grub.cfg
RUN grub-mkstandalone -d "/usr/lib/grub/x86_64-efi" -O x86_64-efi --modules="part_gpt part_msdos" \
    --locales="en@quot" --themes="" -o "/out/EFI/BOOT/bootx64.efi" "boot/grub/grub.cfg=/tmp/grub.cfg" -v 2> /grub.log
CMD ["cp", "--recursive", "--verbose", "--no-target-directory", "/out/EFI", "/EFI"]