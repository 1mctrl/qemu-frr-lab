qemu-system-x86_64 -name r1 -m 256 -enable-kvm -cpu host \
  -drive file=~/virt-net/qcows/r1.qcow2,format=qcow2,if=virtio \
  -netdev tap,id=net0,ifname=tap-r1-gw,script=no,downscript=no \
  -device virtio-net-pci,netdev=net0 \
  -netdev tap,id=net1,ifname=tap-r1-c1,script=no,downscript=no \
  -device virtio-net-pci,netdev=net1 \
  -netdev tap,id=net2,ifname=tap-r1-c2,script=no,downscript=no \
  -device virtio-net-pci,netdev=net2
