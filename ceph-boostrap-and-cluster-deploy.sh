#! /bin/bash

username="nicknjihian" #No password

# The following isn't very efficient.
# Each run of terraform output will need to
# retrieve the latest state snapshot from your configured backend, 
# so running it five times might be slow if your chosen backend has a long round-trip time.

mon1 = "$(terraform output -raw mon1_public_ip)"
mon2 = "$(terraform output -raw mon2_public_ip)"
osd1 = "$(terraform output -raw osd1_public_ip)"
osd2 = "$(terraform output -raw osd2_public_ip)"
osd3 = "$(terraform output -raw osd3_public_ip)"
# mon3"$(terraform output -raw mon3_public_ip)" **add this terraform output.

SCRIPT = "sudo cephadm bootstrap --mon-ip $mon1; ssh-keygen -q -t rsa -N '' -f
~/.ssh/id_rsa <<<y >/dev/null 2>&1; if [[ ! -e /root/.ssh ]]; then sudo mkdir
/root/.ssh; fi; cat ~/.ssh/id_rsa.pub | sudo tee --append
/root/.ssh/authorized_keys; if [[ ! -e /etc/ceph ]]; then sudo mkdir
/etc/ceph; fi; sudo cp ~/.ssh/id_rsa.pub /etc/ceph/ceph.pub; "
ssh nicknjihian@$mon1 "sudo cephadm bootstrap --mon-ip $mon1"

