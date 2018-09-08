FROM alpine:latest

RUN apk add --no-cache vsftpd

RUN echo 'local_enable=NO' > /etc/vsftpd/vsftpd.conf \
    && echo 'write_enable=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo 'local_umask=0444' >> /etc/vsftpd/vsftpd.conf \
    && echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf \
    && echo 'pasv_enable=Yes' >> /etc/vsftpd/vsftpd.conf \
    && echo 'pasv_max_port=11000' >> /etc/vsftpd/vsftpd.conf \
    && echo 'pasv_min_port=10000' >> /etc/vsftpd/vsftpd.conf \
    && echo 'hide_ids=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo '' >> /etc/vsftpd/vsftpd.conf \
    && echo 'listen=NO' >> /etc/vsftpd/vsftpd.conf \
    && echo 'listen_ipv6=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo '' >> /etc/vsftpd/vsftpd.conf \
    && echo 'chown_uploads=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo 'chown_username=ftp' >> /etc/vsftpd/vsftpd.conf \
    && echo '' >> /etc/vsftpd/vsftpd.conf \
    && echo 'delete_failed_uploads=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo 'ls_recurse_enable=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo 'one_process_model=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo '' >> /etc/vsftpd/vsftpd.conf \
    && echo 'anon_root=/var/ftp/' >> /etc/vsftpd/vsftpd.conf \
    && echo 'anon_upload_enable=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo '#anon_other_write_enable=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo 'anon_mkdir_write_enable=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo 'anon_world_readable_only=NO' >> /etc/vsftpd/vsftpd.conf \
    && echo 'no_anon_password=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo 'chown_upload_mode=0444' >> /etc/vsftpd/vsftpd.conf \
    && echo '' >> /etc/vsftpd/vsftpd.conf \
    && echo '#allow_anon_ssl=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo '#ssl_enable=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo '#ssl_request_cert=YES' >> /etc/vsftpd/vsftpd.conf \
    && echo '#validate_cert=NO' >> /etc/vsftpd/vsftpd.conf \
    && mkdir -p /var/ftp \
    && mkdir -p /var/ftp/upload \
    && mkdir -p /var/ftp/download \
    && chown -R ftp:ftp /var/ftp \
    && chmod a-w /var/ftp


VOLUME ["/var/ftp/upload","/var/ftp/download"]

EXPOSE 20 21 10090-10100

CMD chown -R ftp:ftp /var/ftp/upload \
    && chmod -R a-x+X /var/ftp/upload \
    && /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
