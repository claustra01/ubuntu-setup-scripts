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
- よく利用するコマンド群
- c/c++ (build-essential)
- javascript/typescript (nodejs, pnpm)
- python3 (pyenv, poetry)
- golang
- rust (cargo)
- docker
- ngrok
- latex (texlive)


# 注意点

- ngrokの使用にはAuthTokenの設定が必要です。[ここ](https://ngrok.com/)でアカウント登録後トークンを発行し、以下のコマンドを実行してください。
```sh
ngrok config add-authtoken <token>
```
