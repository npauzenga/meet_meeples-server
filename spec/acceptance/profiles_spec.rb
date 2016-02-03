require "rspec_api_documentation/dsl"

RSpec.resource "Profiles" do
  let(:authenticated_user) do
    create(:confirmed_user)
  end

  let(:auth_token) do
    Knock::AuthToken.new(payload: { sub: authenticated_user.id }).token
  end

  get "/profiles/:id" do
    header "Authorization", :auth_token

    parameter "id", <<-DESC, required: true
      The unique ID of the user.
    DESC

    let(:id) { authenticated_user.id }

    example_request "GET /profiles/:id" do
      expect(status).to eq 200
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["first_name"]).
        to eq(authenticated_user.first_name)
    end
  end

  get "/profiles" do
    header "Authorization", :auth_token

    example_request "GET /profiles" do
      expect(status).to eq 200
    end
  end
end
