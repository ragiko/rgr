# 概要
* gitのリモートリポジトリを作成
* ローカルのリポジトリにpull
* リモートのリポジトリーにpush
の一連の流れを行ってくれるscript

# 設定
* gitのAPIが使えるように, rcでApplicationのIDとsecretを登録
```
export CLIENT_ID=...
export CLIENT_SECRET=...
export TOKEN=...
export AUTH_HDR="Authorization: bearer $TOKEN"
```

