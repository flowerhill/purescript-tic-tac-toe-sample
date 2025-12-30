# PureScript 三目並べ

PureScriptとHalogenを使った三目並べゲームのサンプルプロジェクトです。

## 概要

このプロジェクトは、関数型プログラミング言語PureScriptとHalogen UIライブラリを使用して実装された三目並べ（tic-tac-toe）ゲームです。シンプルなゲームロジックとWebインターフェースを通して、PureScriptの基本的な概念とHalogenのコンポーネントシステムを学ぶことができます。

## 機能

- 3x3の三目並べゲーム
- プレイヤー交代機能（O と X）
- 勝利判定（横、縦、斜めの3つ揃い）
- ゲームリセット機能
- レスポンシブなWebインターフェース
- 日本語UI

## 必要なソフトウェア

- [Node.js](https://nodejs.org/) (v16以上推奨)
- [PureScript](https://github.com/purescript/purescript)
- [Spago](https://github.com/purescript/spago) (PureScriptのビルドツール)

## インストール方法

1. リポジトリをクローン:
```bash
git clone <repository-url>
cd purescript-tic-tac-toe-sample
```

2. 依存関係をインストール:
```bash
spago install
```

3. プロジェクトをビルド:
```bash
spago build
```

4. JavaScriptバンドルを生成:
```bash
spago bundle-app --to dist/app.js
```

## 使用方法

1. `index.html`をブラウザで開く
2. ゲーム盤のセルをクリックしてO、Xを配置
3. 3つ揃えば勝利
4. 「リセット」ボタンで新しいゲームを開始

## 開発

### テストの実行

```bash
spago test
```

### 開発サーバーの起動

開発中は以下のコマンドでファイルの変更を監視できます：

```bash
spago build --watch
```

## プロジェクト構造

```
.
├── src/
│   └── Main.purs          # メインのゲームロジックとUI
├── test/
│   └── Main.purs          # テストコード
├── index.html             # HTMLエントリーポイント
├── spago.dhall            # プロジェクト設定
├── packages.dhall         # パッケージ依存関係
└── README.md              # このファイル
```

## 技術スタック

- **PureScript**: 型安全な関数型プログラミング言語
- **Halogen**: PureScript用のUI/DOM操作ライブラリ
- **Spago**: PureScriptのパッケージマネージャーとビルドツール

## 学習リソース

- [PureScript公式ドキュメント](https://github.com/purescript/documentation)
- [Halogenガイド](https://github.com/purescript-halogen/purescript-halogen)
- [PureScript by Example](https://book.purescript.org/)

## ライセンス

このプロジェクトはサンプルコードです。自由にご利用ください。