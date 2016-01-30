require "rspec_api_documentation/dsl"

RSpec.resource "Profiles" do
  let(:authenticated_user) do
    create(:confirmed_user)
  end

  let(:auth_token) do
    Knock::AuthToken.new(payload: { sub: authenticated_user.id }).token
  end

  shared_context "user parameters" do
    parameter "first_name", <<-DESC, scope: :user, required: true
      The first name of the user.
    DESC
    parameter "email", <<-DESC, scope: :user, required: true
      The email of the user.
    DESC
    parameter "last_name", <<-DESC, scope: :user, required: true
      The last name of the user.
    DESC
    parameter "password", <<-DESC, scope: :user, required: true
      The password of the user.
    DESC
    parameter "city", <<-DESC, scope: :user, required: true
      The city of the user.
    DESC
    parameter "state", <<-DESC, scope: :user, required: true
      The state of the user.
    DESC
    parameter "country", <<-DESC, scope: :user, required: true
      The country of the user.
    DESC
  end

  get "/profiles/:id" do
    header "Authorization", :auth_token

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

