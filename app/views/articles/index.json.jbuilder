json.articles @articles do |article|
  json.id article.id
  json.title article.title
  json.abstract article.abstract
  json.body article.body
  json.status article.status_name
end