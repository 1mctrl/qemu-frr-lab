qemu-system-x86_64 -name c1 -m 256 -enable-kvm -cpu host \
  -drive file=~/virt-net/qcows/c1.qcow2,format=qcow2,if=virtio \
  -netdev tap,id=net0,ifname=tap-c1,script=no,downscript=no \
  -device virtio-net-pci,netdev=net0 \
