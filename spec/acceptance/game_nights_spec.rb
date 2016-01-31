require "rspec_api_documentation/dsl"

RSpec.resource "GameNights" do
  let(:authenticated_user) do
    create(:confirmed_user)
  end

  let(:auth_token) do
    Knock::AuthToken.new(payload: { sub: authenticated_user.id }).token
  end

  shared_context "game_night parameters" do
    parameter "name", <<-DESC, scope: :game_night
      The name of the game_night.
    DESC
    parameter "time", <<-DESC, scope: :game_night, required: true
      The time of the game_night.
    DESC
    parameter "location_name", <<-DESC, scope: :game_night, required: true
      The location of the game_night.
    DESC
    parameter "location_address", <<-DESC, scope: :game_night
      The address of the game_night.
    DESC
  end

  post "/game_nights" do
    include_context "game_night parameters"

    let(:name)              { "Waaggh" }
    let(:time)              { "2015-09-12 22:49:27 +0530" }
    let(:location_name)     { "Library" }
    let(:location_address)  { "999 main st. Silver Spring, MD 20910" }

    header "Authorization", :auth_token

    example_request "POST /game_nights" do
      expect(status).to eq 201

      json_response = JSON.parse(response_body)

      expect(json_response["data"]["attributes"]["name"]).
        to eq public_send(:name)

      expect(authenticated_user.game_nights.first.name).
        to eq public_send(:name)

      game_night = GameNight.first

      expect(game_night.users.first).to eq authenticated_user
    end
  end

  patch "/game_nights/:id" do
    include_context "game_night parameters"

    let!(:game_night) { create(:game_night) }
    let(:id) { game_night.id }

    parameter "id", <<-DESC, required: true
      The id of the game_night.
    DESC

    let(:name)              { "New Name" }
    let(:time)              { "2015-09-12 22:49:27 +0530" }
    let(:location_name)     { "Library" }
    let(:location_address)  { "999 main st. Silver Spring, MD 20910" }

    header "Authorization", :auth_token

    example_request "PATCH /game_nights/:id" do
      expect(status).to eq 200

      game_night = JSON.parse(response_body)

      expect(game_night["data"]["attributes"]["name"]).
        to eq public_send(:name)
    end
  end

  get "/game_nights/:id" do
    let!(:game_night) { create(:game_night) }
    let(:id) { game_night.id }
    let(:name) { game_night.name }

    parameter "id", <<-DESC, required: true
      The id of the game_night.
    DESC

    header "Authorization", :auth_token

    example_request "GET /game_nights/:id" do
      expect(status).to eq 200

      game_night = JSON.parse(response_body)

      expect(game_night["data"]["attributes"]["name"]).
        to eq public_send(:name)
    end
  end

  get "/game_nights/" do
    let!(:game_night1) { create(:game_night) }
    let!(:game_night2) { create(:game_night) }
    let!(:game_night3) { create(:game_night) }

    header "Authorization", :auth_token

    example_request "GET /game_nights/" do
      expect(status).to eq 200

      list = JSON.parse(response_body)

      expect(list["data"][0].value?(game_night1.id.to_s)).to be_truthy
      expect(list["data"][1].value?(game_night2.id.to_s)).to be_truthy
      expect(list["data"][2].value?(game_night3.id.to_s)).to be_truthy
    end
  end

  delete "/game_nights/:id" do
    let!(:game_night) { create(:game_night) }
    let(:id) { game_night.id }

    header "Authorization", :auth_token

    parameter "id", <<-DESC, required: true
      The id of the game_night.
    DESC

    example_request "DELETE /game_nights/:id" do
      expect(status).to eq 204
    end
  end
end
