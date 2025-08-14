# ubuntu-vsftpd

https://hub.docker.com/r/culn/ubuntu-vsftpd

docker-compose.yml
```yaml
services:
  vsftpd:
    image: culn/ubuntu-vsftpd:latest
    ports:
      - "21:21"
      - "21000-21010:21000-21010"
    environment:
      USERS: "one:1234;two:1234"
    volumes:
      - ftp_data:/srv/ftp
    restart: always
volumes:
  ftp_data:
```
