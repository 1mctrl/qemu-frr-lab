#!/usr/bin/env bash

qemu-system-x86_64 -name r2 -m 256 -enable-kvm -cpu host \
  -drive file=~/virt-net/qcows/r2.qcow2,format=qcow2,if=virtio \
  -netdev tap,id=net0,ifname=tap-r2-gw,script=no,downscript=no \
  -device virtio-net-pci,netdev=net0 \
  -netdev tap,id=net1,ifname=tap-r2-c3,script=no,downscript=no \
  -device virtio-net-pci,netdev=net1 \
