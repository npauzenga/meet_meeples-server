module Helpers
  def authenticate
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    request.env["HTTP_AUTHORIZATION"] = "bearer #{token}"
  end
end
