json.extract! publication, :id, :type, :title, :body, :embed, :created_at, :updated_at
json.url publication_url(publication, format: :json)
