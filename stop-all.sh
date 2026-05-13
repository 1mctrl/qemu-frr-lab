#!/bin/bash
# stop-all.sh — останавливает все VM

echo "🛑 Останавливаем все машины..."

pkill -f "qemu-system-x86_64.*qemu-frr-lab" || true
pkill -f "gw1.sh" || true
pkill -f "r1.sh" || true
pkill -f "r2.sh" || true
pkill -f "c[1-3].sh" || true

echo "✅ Все машины остановлены."
