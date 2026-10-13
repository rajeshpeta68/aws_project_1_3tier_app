#!/bin/bash
if command -v dnf >/dev/null 2>&1; then
  dnf install -y httpd
else
  yum install -y httpd
fi

TOKEN=$(curl -sX PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
META="http://169.254.169.254/latest/meta-data"
INSTANCE_ID=$(curl -sH "X-aws-ec2-metadata-token: $TOKEN" "$META/instance-id")
PRIVATE_IP=$(curl -sH "X-aws-ec2-metadata-token: $TOKEN" "$META/local-ipv4")
PUBLIC_IP=$(curl -sH "X-aws-ec2-metadata-token: $TOKEN" "$META/public-ipv4")
AZ=$(curl -sH "X-aws-ec2-metadata-token: $TOKEN" "$META/placement/availability-zone")
HOSTNAME=$(hostname)

cat > /var/www/html/index.html <<HTML
<h1>Hello from ${server_name}</h1>
<ul>
  <li>Hostname: $${HOSTNAME}</li>
  <li>Instance ID: $${INSTANCE_ID}</li>
  <li>Private IP: $${PRIVATE_IP}</li>
  <li>Public IP: $${PUBLIC_IP}</li>
  <li>Availability Zone: $${AZ}</li>
</ul>
HTML

systemctl enable --now httpd