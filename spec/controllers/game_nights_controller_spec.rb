include Helpers

RSpec.describe GameNightsController do
  let(:user)       { create(:confirmed_user) }
  let(:game_night) { create(:game_night) }
  let(:serializer) { GameNightSerializer.new(game_night) }
  let(:serialization) do
    ActiveModel::Serializer::Adapter.create(serializer)
  end

  before do
    authenticate
  end

  describe "POST #create" do
    let(:params) do
      { game_night: create_game_night_input.fetch(:game_night_params) }
    end

    let(:create_game_night_input) do
      { game_night_params: {
        name:          game_night.name,
        time:          game_night.time,
        location_name: game_night.location_name }
      }
    end

    let(:create_game_night_context) do
      Interactor::Context.new(errors: :val, game_night: game_night)
    end

    before do
      allow(CreateGameNight).to receive(:call).with(create_game_night_input).
        and_return(create_game_night_context)
    end

    context "when called" do
      it "calls the CreateGameNight interactor" do
        expect(CreateGameNight).to receive(:call)
        post :create, params
      end
    end

    context "when CreateGameNight is a success" do
      it "returns HTTP status 201" do
        post :create, params
        expect(response).to have_http_status(201)
      end

      it "renders the game_night as JSON" do
        post :create, params
        expect(serialization.to_json).to eq(response.body)
      end
    end

    context "when CreateGameNight is a failure" do
      let(:create_game_night_context) do
        double(:context, success?: false, game_night: game_night)
      end

      it "returns HTTP status 422" do
        post :create, params
        expect(response).to have_http_status(422)
      end

      it "returns an error" do
        game_night.errors.add("error")
        post :create, params
        expect(JSON.parse(response.body)).to eq("error")
      end
    end
  end

  describe "PATCH #update" do
    let(:params) do
      { id:         game_night.id,
        game_night: update_game_night_input.fetch(:game_night_params) }
    end

    let(:update_game_night_input) do
      { game_night_params: {
        name:          game_night.name,
        time:          game_night.time,
        location_name: game_night.location_name }
      }
    end

    let(:update_game_night_context) do
      Interactor::Context.new(errors: :val, game_night: game_night)
    end

    before do
      allow(UpdateGameNight).to receive(:call).with(update_game_night_input).
        and_return(update_game_night_context)
    end

    context "when called" do
      it "calls the UpdateGameNight Interactor" do
        expect(UpdateGameNight).to receive(:call)
        patch :update, params
      end
    end

    context "when UpdateGameNight is a success" do
      it "returns HTTP status 200" do
        patch :update, params
        expect(response).to have_http_status(200)
      end

      it "renders the GameNight as JSON" do
        patch :update, params
        expect(serialization.to_json).to eq(response.body)
      end
    end

    context "when UpdateGameNight is a failure" do
      let(:update_game_night_context) do
        double(:context, error: "invalid", success?: false)
      end

      it "renders an error" do
        patch :update, params
        expect(response.body).to eq("invalid")
      end

      it "returns HTTP status 500" do
        patch :update, params
        expect(response).to have_http_status(500)
      end
    end
  end

  describe "GET #show" do
    let(:params) { { id: game_night.id } }
    let(:show_game_night_input) { { id: params.fetch(:id).to_s } }

    let(:show_game_night_context) do
      Interactor::Context.new(errors: :val, game_night: game_night)
    end

    before do
      allow(ShowGameNight).to receive(:call).with(show_game_night_input).
        and_return(show_game_night_context)
    end

    context "when called" do
      it "calls the ShowGameNight Interactor" do
        expect(ShowGameNight).to receive(:call)
        get :show, params
      end
    end

    context "when ShowGameNight is a success" do
      it "returns HTTP status 200" do
        get :show, params
        expect(response).to have_http_status(200)
      end

      it "renders the GameNight as JSON" do
        get :show, params
        expect(serialization.to_json).to eq(response.body)
      end
    end

    context "when ShowGameNight is a failure" do
      let(:show_game_night_context) do
        double(:context, success?: false, game_night: game_night)
      end

      it "returns HTTP status 404" do
        get :show, params
        expect(response).to have_http_status(404)
      end

      it "renders an error" do
        get :show, params
        expect(response.body).to eq("invalid")
      end
    end
  end

  describe "DELETE #delete" do
    let(:params) { { id: game_night.id } }
    let(:delete_game_night_input) { { id: params.fetch(:id).to_s } }

    let(:delete_game_night_context) do
      Interactor::Context.new(errors: :val, game_night: game_night)
    end

    context "when called" do
      it "calls the DeleteGameNight Interactor" do
        expect(DeleteGameNight).to receive(:call)
        delete :delete, params
      end
    end

    context "when DeleteGameNight is a success" do
      it "returns HTTP status 200" do
        delete :destroy, params
        expect(response).to have_http_status(200)
      end
    end

    context "when DeleteGameNight is a failure" do
      let(:delete_game_night_context) do
        double(:context, success?: false, game_night: game_night)
      end

      it "returns HTTP status 500" do
        delete :destroy, params
        expect(response).to have_http_status(500)
      end

      it "renders an error" do
        game_night.errors.add("error")
        delete :destroy, params
        expect(JSON.parse(response.body)).to eq("error")
      end
    end
  end
end
