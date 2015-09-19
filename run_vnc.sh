USER=$(echo -n $(cat user))
HOST=$(echo -n $(cat host))

ssh $USER@$HOST "bash -s" < start_vnc_remote_sh
ssh -L 5901:127.0.0.1:5901 -N -l $USER $HOST
/usr/bin/vncserver -kill :1
