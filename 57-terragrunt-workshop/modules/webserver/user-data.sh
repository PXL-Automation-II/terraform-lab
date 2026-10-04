#!/bin/bash
which busybox || (apt-get update -y && apt-get install -y busybox)

cat > /home/ubuntu/index.html <<EOF
<h1>Hello from ${environment}!</h1>
<p>Server port: ${server_port}</p>
<p>Environment: ${environment}</p>
<p>This server is managed by Terragrunt</p>
EOF

nohup busybox httpd -f -p ${server_port} -h /home/ubuntu &
