#!/bin/bash

create_bridge() {
    local BR="$1" ADDR="$2"
    ip link show "$BR" &>/dev/null || { ip link add name "$BR" type bridge && ip link set "$BR" up; }
    if [ -n "$ADDR" ]; then
        ip addr show "$BR" | grep -q "$ADDR" || ip addr add "$ADDR" dev "$BR"
    fi
}

create_tap() {
    local TAP="$1" BR="$2"
    ip link show "$TAP" &>/dev/null || { ip tuntap add dev "$TAP" mode tap && ip link set "$TAP" up && ip link set "$TAP" master "$BR"; }
}

create_bridge br-host-gw "10.0.0.254/30"
create_bridge br-gw-r1   ""
create_bridge br-gw-r2   ""
create_bridge br-r1-c1   ""
create_bridge br-r1-c2   ""
create_bridge br-r2-c3   ""

# gw tapochki
create_tap tap-gw-host br-host-gw
create_tap tap-gw-r1   br-gw-r1
create_tap tap-gw-r2   br-gw-r2
# r1 tapochki
create_tap tap-r1-gw   br-gw-r1
create_tap tap-r1-c1   br-r1-c1
create_tap tap-r1-c2   br-r1-c2
# r2 tapochki
create_tap tap-r2-gw   br-gw-r2
create_tap tap-r2-c3   br-r2-c3
# client tapochki
create_tap tap-c1      br-r1-c1
create_tap tap-c2      br-r1-c2
create_tap tap-c3      br-r2-c3

sysctl -qw net.ipv4.ip_forward=1
grep -q "net.ipv4.ip_forward=1" /etc/sysctl.conf || echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

UPLINK="${1:-wlan0}"
iptables -t nat -C POSTROUTING -s 10.0.0.0/8 -o "$UPLINK" -j MASQUERADE 2>/dev/null \
    || iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -o "$UPLINK" -j MASQUERADE
iptables -t nat -C POSTROUTING -s 192.168.0.0/16 -o "$UPLINK" -j MASQUERADE 2>/dev/null \
    || iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -o "$UPLINK" -j MASQUERADE

ip -br link show type bridge
