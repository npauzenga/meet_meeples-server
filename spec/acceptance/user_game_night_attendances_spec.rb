require "rspec_api_documentation_helper"

RSpec.resource "UserGameNightAttendance" do
  let(:authenticated_user) do
    create(:confirmed_user)
  end

  let(:auth_token) do
    Knock::AuthToken.new(payload: { sub: authenticated_user.id }).token
  end

  shared_context "user_game_night_attendance parameters" do
    parameter "game_night_id", <<-DESC, scope: :game_night, required: true
      The unique id of the game_night.
    DESC
  end

  post "/game_nights/:game_night_id/game_night_attendances" do
    include_context "user_game_night_attendance parameters"

    let!(:game_night)    { create(:game_night) }
    let(:game_night_id)  { game_night.id }

    header "Authorization", :auth_token

    example_request "POST /game_nights/:game_night_id/game_night_attendances" do
      expect(status).to eq 204

      expect(authenticated_user.game_nights.first.name).to eq(game_night.name)

      expect(game_night.users.first).to eq authenticated_user
    end
  end
end
