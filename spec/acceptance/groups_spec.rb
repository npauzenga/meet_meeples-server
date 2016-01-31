require "rspec_api_documentation/dsl"

RSpec.resource "Groups" do
  let(:authenticated_user) do
    create(:confirmed_user)
  end

  let(:auth_token) do
    Knock::AuthToken.new(payload: { sub: authenticated_user.id }).token
  end

  shared_context "group parameters" do
    parameter "name", <<-DESC, scope: :group, required: true
      The name of the group.
    DESC
    parameter "city", <<-DESC, scope: :group, required: true
      The city where the group is located.
    DESC
    parameter "state", <<-DESC, scope: :group, required: true
      The state where the group is located.
    DESC
    parameter "country", <<-DESC, scope: :group, required: true
      The country where the group is located.
    DESC
    parameter "facebook", <<-DESC, scope: :group, required: true
      The facebook address for the group.
    DESC
    parameter "twitter", <<-DESC, scope: :group, required: true
      The twitter address for the group.
    DESC
  end

  post "/groups" do
    include_context "group parameters"

    let(:name)     { "Waaggh" }
    let(:city)     { "Washington" }
    let(:state)    { "DC" }
    let(:country)  { "USA" }
    let(:facebook) { "facebook.com/waaaggh" }
    let(:twitter)  { "@waaggh" }

    header "Authorization", :auth_token

    example_request "POST /groups" do
      expect(status).to eq 201

      json_response = JSON.parse(response_body)

      expect(json_response["data"]["attributes"]["name"]).
        to eq public_send(:name)

      expect(authenticated_user.groups.first.name).
        to eq public_send(:name)

      group = Group.first

      expect(group.users.first).to eq authenticated_user
    end
  end

  patch "/groups/:id" do
    include_context "group parameters"

    let!(:group) { create(:group) }
    let(:id) { group.id }

    parameter "id", <<-DESC, required: true
      The id of the group.
    DESC

    let(:name)     { "Zombicide Tuesdays" }
    let(:city)     { "Washington" }
    let(:state)    { "DC" }
    let(:country)  { "USA" }
    let(:facebook) { "facebook.com/zombie" }
    let(:twitter)  { "@zombie" }

    header "Authorization", :auth_token

    example_request "PATCH /groups/:id" do
      expect(status).to eq 200

      group = JSON.parse(response_body)

      expect(group["data"]["attributes"]["name"]).
        to eq public_send(:name)
    end
  end

  get "/groups/:id" do
    let!(:group) { create(:group) }
    let(:id) { group.id }
    let(:name) { group.name }

    parameter "id", <<-DESC, required: true
      The id of the group.
    DESC

    header "Authorization", :auth_token

    example_request "GET /groups/:id" do
      expect(status).to eq 200

      group = JSON.parse(response_body)

      expect(group["data"]["attributes"]["name"]).
        to eq public_send(:name)
    end
  end

  get "/groups/" do
    let!(:group1) { create(:group) }
    let!(:group2) { create(:group) }
    let!(:group3) { create(:group) }

    header "Authorization", :auth_token

    example_request "GET /groups/" do
      expect(status).to eq 200

      list = JSON.parse(response_body)

      expect(list["data"][0].value?(group1.id.to_s)).to be_truthy
      expect(list["data"][1].value?(group2.id.to_s)).to be_truthy
      expect(list["data"][2].value?(group3.id.to_s)).to be_truthy
    end
  end

  delete "/groups/:id" do
    let!(:group) { create(:group) }
    let(:id) { group.id }

    header "Authorization", :auth_token

    parameter "id", <<-DESC, required: true
      The id of the group.
    DESC

    example_request "DELETE /groups/:id" do
      expect(status).to eq 204
    end
  end
end
