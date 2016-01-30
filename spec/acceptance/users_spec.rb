require "rspec_api_documentation/dsl"

RSpec.resource "User" do
  let(:authenticated_user) do
    create(:confirmed_user)
  end

  let(:auth_token) do
    Knock::AuthToken.new(payload: { sub: authenticated_user.id }).token
  end

  def schema_path
    "./config/schema/schemata/user.json"
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

  post "/user" do
    include_context "user parameters"

    let(:first_name) { "Nate" }
    let(:email)      { "admin@test.com" }
    let(:last_name)  { "Pauzenga" }
    let(:city)       { "Annapolis" }
    let(:state)      { "MD" }
    let(:country)    { "USA" }
    let(:password)   { "helloworld" }

    example_request "POST /user" do
      expect(status).to eq 201
      json_response = JSON.parse(response_body)
      expect(json_response["jwt"]).to include("payload")
    end
  end

  patch "/user" do
    include_context "user parameters"

    let(:first_name) { "John Doe" }
    let(:email)      { "admin@test.com" }
    let(:last_name)  { "Pauzenga" }
    let(:city)       { "Annapolis" }
    let(:state)      { "MD" }
    let(:country)    { "USA" }
    let(:password)   { "helloworld" }

    header "Authorization", :auth_token

    example_request "PATCH /user" do
      expect(status).to eq 200
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["first_name"]).
        to eq public_send(:first_name)
    end
  end

  delete "/user" do
    header "Authorization", :auth_token

    let(:id) { authenticated_user.id }

    example_request "DELETE /users/:id" do
      expect(status).to eq 204
    end
  end
end
