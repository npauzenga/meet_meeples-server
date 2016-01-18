require "rspec_api_documentation/dsl"

RSpec.resource "Users" do
  shared_context "user parameters" do
    parameter "type", <<-DESC, required: true
      The type of resource. Must be users.
    DESC

    let "type" do
      "users"
    end

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

  post "/users" do
    include_context "user parameters"

    let(:first_name) { "Nate" }
    let(:email)      { "admin@test.com" }
    let(:last_name)  { "Pauzenga" }
    let(:city)       { "Annapolis" }
    let(:state)      { "MD" }
    let(:country)    { "USA" }
    let(:password)   { "helloworld" }

    example_request "POST /users" do
      expect(status).to eq 201
      json_response = JSON.parse(response_body)
      expect(json_response["jwt"]).to include("payload") 
    end
  end

  patch "/users/:user_id" do
    include_context "user parameters"

    let!(:user) { create(:confirmed_user) }
    let(:token) { token = Knock::AuthToken.new(payload: { sub: user.id }).token }

    header "Authorization", :token


    parameter "id", <<-DESC, scope: :user, required: true
      The id of the user.
    DESC

    let(:id) { user.id.to_s }

    let(:first_name) { "Xavier" }
    
    example_request "PATCH /users/:id" do
      expect(status).to eq 200
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["first_name"]).to eq public_send(:first_name)
    end
  end
end
