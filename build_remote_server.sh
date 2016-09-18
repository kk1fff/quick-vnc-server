#/bin/bash

SUPERUSER=`user superuser`
USER=`cat user`
HOST=`cat host`
PUBKEY=$(cat ~/.ssh/id_rsa.pub)

SETUPHOST=$SUPERUSER@$HOST

echo "server: $HOST"

echo "Install public key..."
ssh -C $SETUPHOST "bash -s" <<EOF
mkdir -p ~/.ssh
echo "$PUBKEY" >> ~/.ssh/authorized_keys
chmod -R go-rw ~/.ssh
EOF

echo "Setup new user..."
ssh -C $SETUPHOST "bash -s" <<EOF
useradd -m $USER
mkdir -p /home/$USER/.ssh
echo "$PUBKEY" > /home/$USER/.ssh/authorized_keys
chown -R $USER:$USER /home/$USER/.ssh
chmod -R go-rw /home/$USER/.ssh
EOF

TMP_SCRIPT_NAME=$(pwgen -sn 10)

echo "Update system and install packages..."
ssh -C root@$HOST "cat > $TMP_SCRIPT_NAME" <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install emacs tightvncserver xfce4 xfce4-goodies pwgen chromium-browser rsync -y
EOF

ssh -C root@$HOST -t "sh $TMP_SCRIPT_NAME"
ssh -C root@$HOST "rm $TMP_SCRIPT_NAME"
