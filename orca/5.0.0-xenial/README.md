# orca docker

## Summary

日医標準レセプトソフト(ORCA)をDockerコンテナ上で実行します。

## Docker HUB
https://hub.docker.com/r/homis/orca

## Usage

```console
docker run -p 8000:8000 homis/orca:5.0.0-xenial
```

## 環境変数
- ORMASTER_PASSWORD : ormasterのパスワード（デフォルト：ormaster）
- DISABLE_ORCA: 1を設定するとpostgresのみ起動し、orcaサービスを起動しない（デフォルト：設定なし）
