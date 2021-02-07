# Coffee-oma

コーヒーに関する器具や、豆などの評価や感想を、共有するwebアプリケーションです。

### [リンク]:http://coffee-oma.com






# 特に見ていただきたい点
- ### インフラ面
  - 開発環境ではdocker-composeを利用し、本番環境ではAWS(ECS Fargate)を利用している
  - CircleCIを利用し、CI/CDパイプラインを構築している
  - Terraformを使い、インフラをコード化している
- ### バックエンド面
  -　
- ### その他
  - チーム開発を意識し、Github flowに従った開発手法を取り入れている点。

# クラウドアーキテクチャー
![ポートフォリオクラウドアーキテクチャー](https://user-images.githubusercontent.com/48266893/100878050-0292ca00-34ed-11eb-94c6-137fb8bdfb9b.png)


# ER図
![DB](https://user-images.githubusercontent.com/48266893/106903759-be66b480-673d-11eb-8fc9-19df78d57f38.png)


## 機能一覧
  - ユーザ機能
  - コーヒーアイテム投稿機能
  - コーヒー豆投稿機能
  - 投稿に対するレビュー機能
  - レビューに対しての通報機能
  - お気に入り機能(アイテム、豆)
  - お気に入り機能(レビュー)
  - 通知機能
  - DM機能(チャットルーム方式)
  - お問い合わせ機能
  - フォロー機能
  - コーヒーの抽出レシピの投稿機能(豆のレビューに紐付け)
