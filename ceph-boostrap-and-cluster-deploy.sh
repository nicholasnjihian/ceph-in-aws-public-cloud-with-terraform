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


# Execute bootstrap command and copy ssh keys to all nodes in the cluster.
read -r -d '' BOOTSTRAP_CLUSTER_SCRIPT <<EOM
sudo cephadm bootstrap --mon-ip $mon1 --ssh-user $username;
sudo ceph -v;
sudo ceph status;
sudo ceph telemetry on;

ssh-copy-id -f -i /etc/ceph/ceph.pub root@$mon2;
ssh-copy-id -f -i /etc/ceph/ceph.pub root@$osd1;
ssh-copy-id -f -i /etc/ceph/ceph.pub root@$osd2;
ssh-copy-id -f -i /etc/ceph/ceph.pub root@$osd3;

EOM

ssh -t $username@$mon1 "$BOOTSTRAP_CLUSTER_SCRIPT"



read -r -d '' PREP_OSDS <<EOM
sudo apt update;
sudo apt upgrade -y;
sudo apt install -y lvm2;

sudo pvcreate /dev/sdd;
sudo vgcreate vg00 /dev/sdd;
sudo lvcreate -v -l 100%FREE -n lvol vg00
sudo lvdisplay /dev/vg00/lvol
EOM

for osd_node in $osd1 $osd2 $osd3; do
  ssh -t $username@$osd_node "$PREP_OSDS";
done


# Add the Other hosts to the Ceph cluster
read -r -d '' ADD_HOSTS <<EOM
sudo ceph orch host add mon2 $mon2 --labels _admin;
sudo ceph orch host add osd1 $osd1;
sudo ceph orch host add osd1 $osd2;
sudo ceph orch host add osd1 $osd3;
EOM

ssh -t $username@$mon1 "ADD_HOSTS"

# View the current hosts and labels
ssh -t $username@$mon1 "sudo ceph orch host ls"

# Print a list of devices discovered by cephadm
ssh -t $username@$mon1 "sudo ceph orch device ls"

# Use cephadm "enhanced device scan" to view the health status of the
# discovered devices:
ssh -t $username@$mon1 "sudo ceph config set mgr mgr/cephadm/device_enhanced_scan true"
ssh -t $username@$mon1 "sudo ceph orch device ls"

# Tell Ceph to consume any available and unused storage device:
ssh -t $username@$mon1 "sudo ceph orch apply osd --all-available-devices
--unmanaged=true"


