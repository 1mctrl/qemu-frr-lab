# qemu-frr-lab

Готовая лаборатория FRR на QEMU.

**Скачал → git lfs pull → запустил → работает.**

## Быстрый старт

```bash
git clone https://github.com/1mctrl/qemu-frr-lab.git
cd qemu-frr-lab
git lfs pull

chmod +x *.sh starts/*.sh
sudo ./setup-net.sh
./start-all.sh
```

## Команды

- `./start-all.sh` — запустить всю лабораторию
- `./stop-all.sh`  — остановить все машины
- `sudo ./setup-net.sh` — настроить сеть

QCOW2 уже содержат настроенный FRR.
