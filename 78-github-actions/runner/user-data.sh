#!/bin/bash
# Runs once, as root, when the instance boots for the first time.
set -euo pipefail

# unzip: hashicorp/setup-terraform needs it to unpack Terraform
apt-get update
apt-get install -y unzip

# The runner runs as its own user, not as root
useradd --create-home --shell /bin/bash runner
mkdir /home/runner/actions-runner
cd /home/runner/actions-runner

# Download the runner and check that the file is the published one
curl -sSL -o runner.tar.gz \
  "https://github.com/actions/runner/releases/download/v${runner_version}/actions-runner-linux-x64-${runner_version}.tar.gz"
echo "${runner_sha256}  runner.tar.gz" | sha256sum -c -
tar xzf runner.tar.gz
rm runner.tar.gz
./bin/installdependencies.sh
chown -R runner:runner /home/runner

# Register with the repository, with the extra label "lab"
sudo -u runner ./config.sh --unattended \
  --url "${repo_url}" \
  --token "${runner_token}" \
  --name "lab-runner" \
  --labels "lab" \
  --replace

# Install as a service: it starts again when the instance starts
./svc.sh install runner
./svc.sh start
