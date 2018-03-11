This simple daemon that just calls `autorandr` executable if udev detects
monitor connection.

# Install or build as nix package

To install it in environment just:

```nix
nix-env -f autoautorandr.nix -i autoautorandr
```
