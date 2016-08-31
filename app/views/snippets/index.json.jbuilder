json.array!(@snippets) do |snippet|
  json.extract! snippet, :id, :name, :language, :code, :vault_id
  json.url snippet_url(snippet, format: :json)
end
