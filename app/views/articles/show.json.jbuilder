json.article do
  json.id @article.id
  json.title @article.title
  json.abstract @article.abstract
  json.created_at @article.created_at.strftime("%Y-%m-%d").to_s
  json.status @article.status_name
  json.body @article.body
end