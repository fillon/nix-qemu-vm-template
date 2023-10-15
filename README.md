# nix-qemu-vm-template

## Build VM

```bash
rm nixos.qcow2
nixos-rebuild build-vm --flake .#vm

./result/bin/run-nixos-vm
```
