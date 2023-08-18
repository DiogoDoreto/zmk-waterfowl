# Diogo's Waterfowl Config

## Building locally with Podman

Preparing the container:

```
podman create -it --name=zmk --mount="type=bind,source=/d/git/zmk/app,destination=/workspaces/app" --mount="type=bind,source=/d/git/zmk-waterfowl/config,target=/workspaces/zmk-config" --mount="type=volume,source=zmk-zephyr,target=/workspaces/zephyr" --mount="type=volume,source=zmk-zephyr-modules,target=/workspaces/modules" --mount="type=volume,source=zmk-zephyr-tools,target=/workspaces/tools" docker.io/zmkfirmware/zmk-dev-arm:3.2 /bin/bash

podman start zmk
podman exec -w=/workspaces zmk west init -l app
podman exec -w=/workspaces zmk west update
podman restart zmk
```

Running the build:

```
podman exec -w=/workspaces/app zmk west build -d build/left -b nice_nano_v2 -- -DSHIELD=waterfowl_left -DZMK_CONFIG="/workspaces/zmk-config"
podman exec -w=/workspaces/app zmk west build -d build/right -b nice_nano_v2 -- -DSHIELD=waterfowl_right -DZMK_CONFIG="/workspaces/zmk-config"
```

Then flash the file in `zmk/app/build/left|right/zephyr/zmk.uf2`
