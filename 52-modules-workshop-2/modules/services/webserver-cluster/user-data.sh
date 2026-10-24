#!/bin/bash
which busybox || (apt-get update -y && apt-get install -y busybox)

cat > /home/ubuntu/index.html <<EOF
<h1>${server_text}</h1>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF

nohup busybox httpd -f -p ${server_port} -h /home/ubuntu &
