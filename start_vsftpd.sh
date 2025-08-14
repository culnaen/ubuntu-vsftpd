#!/bin/bash
set -e

IFS=';' read -ra USERS <<< "$USERS"

FTP_PATH=/srv/ftp
mkdir -p $FTP_PATH


for u in "${USERS[@]}"; do
    USERNAME=$(echo "$u" | cut -d':' -f1)
    GROUP=$USERNAME
    PASSWORD=$(echo "$u" | cut -d':' -f2)

    if id "$USERNAME" &>/dev/null; then
        echo "User $USERNAME already exists"
    else
        echo "add user $USERNAME"
        
        if ! getent group "$GROUP" &>/dev/null; then
            groupadd "$GROUP"
        fi
        useradd -m -d "$FTP_PATH/$USERNAME" -s "/bin/false" -g "$GROUP" "$USERNAME"
        echo "$USERNAME:$PASSWORD" | chpasswd
        chown -R "$USERNAME:$GROUP" "$FTP_PATH/$USERNAME"
        unset USERNAME GROUP PASSWORD
    fi
done

mkdir -p /var/run/vsftpd/empty && chmod 755 /var/run/vsftpd/empty

echo "Starting vsftpd..."
exec /usr/sbin/vsftpd /etc/vsftpd.conf
