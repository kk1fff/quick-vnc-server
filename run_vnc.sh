#!/bin/bash

USER=$(cat user)
HOST=$(cat host)

ssh $USER@$HOST "bash -s" < start_vnc_remote_sh

echo "Connect at vnc://127.0.0.1:5901"

ssh -L 5901:127.0.0.1:5901 -NC -l $USER $HOST
ssh $USER@$HOST "/usr/bin/vncserver -kill :1"
