module RequestHelpers
  def json
    JSON.parse(response.body)
  end

  def authenticate
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    request.env["HTTP_AUTHORIZATION"] = "bearer #{token}"
  end

  def serialize(resource)
    ActiveModel::SerializableResource.new(resource).to_json
  end
end
