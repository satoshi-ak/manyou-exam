# README

- Tsak

| Columu  | Date   |
|---------|--------|
| title   | string |
| content | text   |

- User

| Columu  | Date   |
|---------|--------|
| user    | string |
| email   | string |
| password| string |
| password_digest | string |

- Label

| Columu  | Date   |
|---------|--------|
| name    | string |

> Herokuへのデプロイ手順
>
>アセットプリコンパイルをする
>$ rails assets:precompile RAILS_ENV=production
>コミットする
>git add -A
>git commit -m "コミットメッセージ"
>Heroku buildpackを追加する
>heroku buildpacks:set heroku/ruby
>heroku buildpacks:add --index 1 heroku/nodejs
>デプロイをする
> git push heroku master
