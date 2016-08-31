json.array!(@vaults) do |vault|
  json.extract! vault, :id, :name, :readme, :exposure, :user_id
  json.url vault_url(vault, format: :json)
end
