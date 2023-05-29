以下の環境を構築する Dockerfile です。
コピーして使用してもいいが責任は取れません 🙇

- python: 3.7.3
- CUDA: 11.8.0
- pytorch: 1.13.1

## 使い方

1. イメージをビルドする
   ```bash
   docker build -t cuda11 .
   ```
1. host のコードを `src` ディレクトリにまとめる
1. host の `src` と コンテナ内の `home/src` をバインディングしながら run
   ```bash
   docker run -it -v "$(pwd)"/src:/src cuda11
   ```
