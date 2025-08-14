FROM ubuntu:20.04

RUN apt update && \
    apt install -y vsftpd && \
    rm -rf /var/lib/apt/lists/*

COPY vsftpd.conf /etc/vsftpd.conf
COPY start_vsftpd.sh /bin/start_vsftpd.sh

RUN echo "/bin/false" >> /etc/shells
RUN chmod +x /bin/start_vsftpd.sh

EXPOSE 21 21000-21010

ENTRYPOINT ["/bin/start_vsftpd.sh"]