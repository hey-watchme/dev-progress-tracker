# dev-progress-tracker

hey-watchme組織全体の開発進捗を自動でNotionに記録するツールです。

## 📊 機能

### 1. 毎日自動レポート
- hey-watchme組織内の全リポジトリのアクティビティを24時間ごとに集計
- 毎日JST 22:00に自動実行
- コミット数、コミットメッセージ、アクティブなリポジトリをNotionに記録

### 2. 過去データ取得
- 手動実行で過去30日分（または任意の日数）のデータを一括取得
- 日付ごとにNotionに記録

## 🎨 記録フォーマット

Notionに記録されるアクティビティは以下のような見やすいフォーマットです：

```
📅 Activity Report

📦 app-ios (3 commits)
  • [Kaya Matsumoto] fix: デバイス管理とUI表示の改善
  • [Kaya Matsumoto] docs: add deployment failure patterns
  • [Kaya Matsumoto] docs: update routing details

📦 api-demo-generator (2 commits)
  • [Kaya Matsumoto] feat: add weekly aggregator endpoint
  • [Kaya Matsumoto] fix: handle vibe_transcriber_result
```

- リポジトリごとにグループ化
- コミット数を表示
- 長いメッセージは100文字で切り捨て
- 絵文字で視認性向上

## 🚀 使い方

### 毎日自動レポート（設定済み）

毎日JST 22:00に自動実行されます。特に操作は不要です。

### 手動実行

#### 今日のアクティビティを即座に記録
```bash
gh workflow run notion_report.yml --repo hey-watchme/dev-progress-tracker
```

#### 過去30日分のデータを取得
```bash
gh workflow run notion_report_monthly.yml --repo hey-watchme/dev-progress-tracker
```

#### 過去の任意の日数分を取得
```bash
# 過去7日分
gh workflow run notion_report_monthly.yml --repo hey-watchme/dev-progress-tracker -f days=7

# 過去60日分
gh workflow run notion_report_monthly.yml --repo hey-watchme/dev-progress-tracker -f days=60
```

### 実行状況の確認

```bash
# 最新の実行状況を確認
gh run list --repo hey-watchme/dev-progress-tracker --limit 3

# リアルタイム監視
gh run watch <run-id> --repo hey-watchme/dev-progress-tracker
```

## 📝 Notion設定

### 必要なプロパティ

Notionデータベースに以下のプロパティが必要です：

| プロパティ名 | 型 | 説明 |
|-------------|-----|------|
| Title | Title | レポートのタイトル（例：Report 2025-11-28） |
| Date | Date | 記録日 |
| Commits | Number | コミット数 |
| Activities | Text | コミットメッセージの詳細 |
| Repositories | Multi-select | アクティブだったリポジトリ |

### Integration設定

1. Notionで「GitHub Daily Report」Integration を作成済み
2. データベースの「Connections」でIntegrationを接続済み

## 🔧 GitHub Secrets設定（設定済み）

リポジトリの Settings → Secrets and variables → Actions で以下を設定：

- `NOTION_TOKEN`: Notion Integration Token
- `NOTION_DATABASE_ID`: NotionデータベースのID

## 📅 記録される内容

- **日付ごとのコミット数**
- **コミットメッセージの詳細**（リポジトリごとにグループ化）
- **アクティブだったリポジトリ一覧**
- **コミット作成者**

## 🎯 対象範囲

- **組織**: hey-watchme
- **対象**: 組織内の全リポジトリ
- **期間**: 過去24時間（日次レポート）/ 任意の日数（月次レポート）

## ⚙️ ワークフロー

### 1. `notion_report.yml` - 日次レポート
- **トリガー**: 毎日 UTC 13:00（JST 22:00）/ 手動実行
- **処理**: 過去24時間のコミットを取得してNotionに記録

### 2. `notion_report_monthly.yml` - 過去データ取得
- **トリガー**: 手動実行のみ
- **処理**: 指定日数分のコミットを日付ごとに取得してNotionに記録
- **パラメータ**: `days`（デフォルト: 30）

## 🔍 トラブルシューティング

### Notionに記録されない場合

1. **Integration接続を確認**
   - Notionデータベースの「Connections」で「GitHub Daily Report」が接続されているか確認

2. **プロパティ名を確認**
   - プロパティ名が正確か確認（大文字小文字、末尾のスペースに注意）

3. **実行ログを確認**
   ```bash
   gh run view <run-id> --repo hey-watchme/dev-progress-tracker --log
   ```

### GitHub Actions が失敗する場合

- GitHub Secrets（`NOTION_TOKEN`, `NOTION_DATABASE_ID`）が正しく設定されているか確認

## 📚 参考リンク

- [Notion API Documentation](https://developers.notion.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [hey-watchme GitHub Organization](https://github.com/hey-watchme)
