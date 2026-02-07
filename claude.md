## 1. プロジェクトの基本情報

### プロジェクト概要
-Flutterを使ったモバイルアプリです。格闘技について語り合う掲示板アプリ

### 開発ルール
-日本語で回答するようにしてください。


## 2.アーキテクチャ

　アーキテクチャは基本的にMVVMを導入する

lib/
├── main.dart
├── core/                       # 基盤機能
│   ├── assets/                 # 画像・アイコン
│   ├── config/                 # 設定・環境
│   ├── error/                  # エラー
│   ├── network/                # Dio/Requestable/ApiResponse 等
│   └── util/                   # ユーティリティ
├── data/                       # データ層（実装）
│   ├── board|editprofile|...   # 機能ごとのディレクトリ
│   │   ├── api/                # Retrofit等のAPIインターフェース
│   │   ├── datastore/          # API呼び出し調停・エラーマッピング
│   │   ├── request/            # リクエスト/DTO/クエリモデル
│   │   └── response/           # 必要に応じてレスポンスDTO
├── domain/                     # ドメイン層（ビジネスロジック）
│   ├── entity/                 # エンティティ
│   └── usecases/               # ユースケース
├── presentation/               # UI 層
│   └── message|signin|...      # state / viewModel / view
└── providers/                  # DataStore/UseCaseのProviderを機能別に配置
    ├── datastore/              # DataStoreのProvider定義（feature配下）
    └── usecase/                # UseCaseのProvider定義（feature配下）
└── routing/                    # ルーティング


### Domain Layer（ドメイン層）
-プロジェクトの心臓部であり、外部（APIやUI）に依存しない純粋なビジネスロジックを定義します。

-entity/: アプリ全体で扱うデータの実体（Class）を定義します。freezedなどを用いてイミュータブルに定義するのが一般的です。

-usecases/: **「ユーザーが何をしたいか」**という具体的なアクション（例：LoginUseCase, GetPostListUseCase）を定義します。

-責務: DataStore（リポジトリ）を呼び出し、必要に応じてデータの加工やバリデーションを行い、結果をPresentation層に返します。


###  Data Layer（データ層）
-**「どうやってデータを取得・保存するか」**という詳細な実装を受け持ちます。

-api/: Retrofitなどのインターフェースを定義し、エンドポイントとの通信を抽象化します。

-request/ / response/: API通信専用のDTO（Data Transfer Object）です。Domain層のEntityと分離することで、バックエンドの仕様変更がUIに直撃するのを防ぎます。

-datastore/: APIやローカルDBの呼び出しを調停します。

-責務: 通信成功時のレスポンスをEntityに変換（マッピング）したり、例外をアプリ独自のFailure型に変換して投げ直したりします。


### Presentation Layer（UI層）
**「ユーザーにどう見せるか」と「ユーザーの操作をどう受け取るか」**を担当します。

-view: 画面そのもの（StatelessWidget/ConsumerWidget）。ロジックは持ちません。

-viewModel: 画面の状態（State）を管理し、UseCaseを呼び出します。

-state: 画面に表示するためのデータを保持するモデルです。


### Providers（依存関係の注入）
-この構成の特徴的な部分です。DataStoreやUseCaseの実態をどこからでも参照できるように管理します。

-責務: インスタンスの生成と依存関係の解決。例えば「このUseCaseは、どのDataStoreを使うか」といった紐付けをここで行い、Presentation層が実装の詳細を知らなくて済むようにします。


##　3.開発ルール

-ハードコーディングはやめる
-コメントはわかりやすく書く
-メソッド名や変数名やファイル名はわかりやすいものにする
-viewファイルは200行以上になったら別のwidgetファイルを作ってそこに切り出す