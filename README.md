# dev-progress-tracker

hey-watchme組織全体の開発進捗を自動でNotionに記録するツールです。

## 機能

- hey-watchme組織内の全リポジトリのアクティビティを24時間ごとに集計
- コミット数、コミットメッセージ、アクティブなリポジトリをNotionに記録
- 毎日JST 22:00に自動実行（手動実行も可能）

## セットアップ

### 1. Notion設定

Notionデータベースに以下のプロパティが必要です：

| プロパティ名 | 型 |
|-------------|-----|
| Title | Title |
| Date | Date |
| Commits | Number |
| Activities | Text |
| Repositories | Multi-select |

### 2. GitHub Secrets設定

リポジトリの Settings → Secrets and variables → Actions で以下を設定：

- `NOTION_TOKEN`: Notion Integration Token
- `NOTION_DATABASE_ID`: NotionデータベースのID

### 3. 実行

- 自動実行: 毎日JST 22:00（UTC 13:00）
- 手動実行: GitHub Actions → "Daily Progress Report to Notion" → "Run workflow"

## 記録される内容

- 各リポジトリのコミットメッセージ（過去24時間分）
- コミット総数
- アクティブだったリポジトリのリスト
