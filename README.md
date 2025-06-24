# 使い方

- このコマンドでスクリプトをダウンロードできます
```sh
curl -L https://raw.githubusercontent.com/claustra01/ubuntu-setup-scripts/main/all_in_one.sh -o all_in_one.sh
chmod +x all_in_one.sh
```

- このコマンドでスクリプトを実行できます
    - `error: reboot terminal and try again!`というメッセージが表示されたらターミナルを再起動して再度実行してください
    - `all installation completed!`というメッセージが表示されたら全ての環境構築が完了しています
```sh
./all_in_one.sh
```


# インストールされるもの
- C/C++ (build-essential)
- JavaScript/TypeScript (node.js,pnpm)
- Python (pyenv,poetry)
- Java (jdk,jre)
- Golang
- Rust (cargo)
- Gradle
- PostgreSQL
- ngrok
- docker
- LaTeX (texlive) [VSCode参考](https://qiita.com/uoyuki/items/c0b3feeb80f9a2699759)
- CTFによく使用するツール群
- その他よく使用するコマンド群

# 注意点
- ターミナルの再起動が必要です。一度スクリプトを実行した後、再起動して再度実行してください。
- 環境によっては権限の変更が必要になります。その場合は以下のコマンドを実行してください。
```sh
chmod -R +x .
```
- ngrokの使用にはAuthTokenの設定が必要です。[ここ](https://ngrok.com/)でアカウント登録後トークンを発行し、以下のコマンドを実行してください。
```sh
ngrok config add-authtoken <token>
```
