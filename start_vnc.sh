PASS=$(pwgen -syn 8)

DISPLAY="1"
DEPTH="16"
GEOMETRY="1024x768"

cat ~/.vnc/xstartup <<EOF
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4
EOF

chmod a+x ~/.vnc/xstartup

vncpasswd > ~/.vnc/passed <<EOF
$PASS
EOF

/usr/bin/vncserver -depth ${DEPTH} -geometry ${GEOMETRY} :${DISPLAY} -localhost

echo $PASS
