#!/bin/bash
# start-all.sh — запускает всю лабораторию

echo "🚀 Запуск qemu-frr-lab..."

# Создаём сеть, если ещё не создана
if ! ip link show br0 >/dev/null 2>&1; then
    echo "Настройка сети..."
    sudo ./setup-net.sh
fi

# Запуск всех машин
./starts/gw1.sh &
sleep 1
./starts/r1.sh &
sleep 1
./starts/r2.sh &
sleep 1
./starts/c1.sh &
sleep 1
./starts/c2.sh &
sleep 1
./starts/c3.sh &

echo "✅ Лаборатория запущена."
echo "Для остановки выполните: ./stop-all.sh"
