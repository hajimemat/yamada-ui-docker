# Yamada UI Docker

## Yamada UI 適応のNEXTJS

別名ギャルのパンティーテスト

## ビルド方法

```sh
git clone https://avap.codes/avap/public/yamada/yamada-ui-docker.git
cd yamada-ui-docker
docker build . -t yamada-ui-docker
```

## 実行方法

```sh
mkdir the_panties
cd the_panties
docker run --name the_panties \
    -p 3000:3000 \
    -v $(pwd):/app \
    -e HOST_UID=$(id -u) \
    -e HOST_GID=$(id -g) -d run dev
```
