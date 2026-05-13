qemu-system-x86_64 \
  -name gw -m 512 -enable-kvm -cpu host \
  -drive file=~/virt-net/qcows/gw.qcow2,format=qcow2,if=virtio \
  -netdev tap,id=net0,ifname=tap-gw-host,script=no,downscript=no \
  -device virtio-net-pci,netdev=net0 \
  -netdev tap,id=net1,ifname=tap-gw-r1,script=no,downscript=no \
  -device virtio-net-pci,netdev=net1 \
  -netdev tap,id=net2,ifname=tap-gw-r2,script=no,downscript=no \
  -device virtio-net-pci,netdev=net2 \
#  -daemonize \
#  -display none \
#  -nographics \
#   -serial mon:stdio
