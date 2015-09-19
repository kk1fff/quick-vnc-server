
USER=$(echo -n $(cat user))
HOST=$(echo -n $(cat host))
PUBKEY=$(echo -n $(cat ~/.ssh/id_rsa.pub))

echo "Install public key..."
ssh -C root@$HOST "bash -s" <<EOF
mkdir -p ~/.ssh
echo "$PUBKEY" > ~/.ssh/authorized_keys
chmod -R go-rw ~/.ssh
EOF

echo "Setup new user..."
ssh -C root@$HOST "bash -s" <<EOF
useradd -m $USER
mkdir -p /home/$USER/.ssh
echo "$PUBKEY" > /home/$USER/.ssh/authorized_keys
chown -R $UESR:$USER /home/$USER/.ssh
chmod -R go-rw /home/$USER/.ssh
EOF

echo "Update system and install packages..."
ssh -C root@$HOST "bash -s" <<EOF
apt-get update
apt-get dist-upgrade -y
apt-get install emacs tightvncserver xfce4 xfce4-goodies -y
EOF

