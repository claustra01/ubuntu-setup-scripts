# これはなに？
開発やCTFで個人的によく使うものを全部まとめて環境構築するスクリプトです

# 使い方

- このコマンドでスクリプトをダウンロードできます
```sh
curl -L https://raw.githubusercontent.com/claustra01/ubuntu-setup-scripts/main/all_in_one.sh -o all_in_one.sh && chmod +x all_in_one.sh
```

- このコマンドでスクリプトを実行できます
```sh
./all_in_one.sh
```

- 途中で何らかの操作を求められた場合、いい感じに対応してください
- `error: reboot terminal and try again!`というメッセージが表示された場合、ターミナルを再起動して再度実行してください
- 全ての環境構築が完了後、`all installation completed! reboot terminal!`というメッセージが表示されます
- 環境構築完了後はターミナルを一度再起動してください


# インストールされるもの
- よく利用するコマンド群
- c/c++ (build-essential)
- javascript/typescript (nodejs, pnpm)
- python3 (poetry)
- golang
- rust (cargo)
- docker
- ngrok
- latex (texlive)
- sagemath
- CTFでよく利用するツール群


# 注意点

- ngrokを使用する前に[ここ](https://ngrok.com/)でアカウント登録後トークンを発行し、以下のコマンドを実行してください
```sh
ngrok config add-authtoken <token>
```
