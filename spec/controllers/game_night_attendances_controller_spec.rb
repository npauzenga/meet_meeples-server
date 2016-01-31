RSpec.describe GameNightAttendancesController do
  describe "POST #create" do
    let(:user)       { create(:confirmed_user) }
    let(:game_night) { create(:game_night) }
    let(:params)     { { game_night_id: game_night.id.to_s } }

    let(:arguments)  do
      { user_id: user.id, game_night_id: params[:game_night_id] }
    end

    let(:context)    { double(:context, success?: true) }

    before(:example) do
      authenticate

      allow(CreateGameNightAttendance).to receive(:call).with(arguments).
        and_return(context)

      allow(context).to receive(:errors).and_return(["join failed"])
    end

    it "calls CreatePasswordResetOrganizer" do
      expect(CreateGameNightAttendance).to receive(:call)
      post :create, params
    end

    context "when successful" do
      it "returns HTTP status 204" do
        post :create, params
        expect(response).to have_http_status(204)
      end
    end

    context "when unsuccessful" do
      let(:context) { double(:context, success?: false) }

      it "returns HTTP status 500" do
        post :create, params
        expect(response).to have_http_status(500)
      end

      it "renders an error" do
        post :create, params
        expect(json).to eq(["join failed"])
      end
    end
  end
end
