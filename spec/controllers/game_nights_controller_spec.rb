RSpec.describe GameNightsController do
  let(:user)       { create(:confirmed_user) }
  let(:game_night) { create(:game_night) }

  before do
    authenticate
  end

  describe "POST #create" do
    let(:params) do
      { game_night: create_model_input.fetch(:model_params) }
    end

    let(:create_model_input) do
      { active_record_class: GameNight,
        model_params:        {
          name:             game_night.name,
          time:             game_night.time,
          location_name:    game_night.location_name,
          location_address: game_night.location_address }
      }
    end

    let(:create_model_context) do
      Interactor::Context.new(errors: :val, model: game_night)
    end

    before do
      allow(CreateModel).to receive(:call).with(create_model_input).
        and_return(create_model_context)
    end

    context "when called" do
      it "calls the CreateModel interactor" do
        expect(CreateModel).to receive(:call)
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
        expect(serialize(game_night)).to eq(response.body)
      end
    end

    context "when CreateGameNight is a failure" do
      let(:create_model_context) do
        double(:context, success?: false, model: game_night)
      end

      it "returns HTTP status 422" do
        post :create, params
        expect(response).to have_http_status(422)
      end

      it "returns an error" do
        game_night.errors.add(:name, "error")
        post :create, params
        expect(json["name"]).to eq(["error"])
      end
    end
  end

  describe "PATCH #update" do
    let(:params) do
      { id:         game_night.id,
        game_night: update_model_input.fetch(:model_params) }
    end

    let(:update_model_input) do
      { active_record_class: GameNight,
        id:                  game_night.id.to_s,
        model_params:        {
          name:             game_night.name,
          time:             game_night.time,
          location_name:    game_night.location_name,
          location_address: game_night.location_address }
      }
    end

    let(:update_model_context) do
      Interactor::Context.new(errors: :val, model: game_night)
    end

    before do
      allow(UpdateModel).to receive(:call).with(update_model_input).
        and_return(update_model_context)
    end

    context "when called" do
      it "calls the UpdateModel Interactor" do
        expect(UpdateModel).to receive(:call)
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
        expect(serialize(game_night)).to eq(response.body)
      end
    end

    context "when UpdateGameNight is a failure" do
      let(:update_model_context) do
        double(:context, success?: false, model: game_night)
      end

      it "renders an error" do
        game_night.errors.add(:name, "error")
        patch :update, params
        expect(json["name"]).to eq(["error"])
      end

      it "returns HTTP status 422" do
        patch :update, params
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "GET #show" do
    let(:params) { { id: game_night.id } }
    let(:show_model_input) do
      { active_record_class: GameNight, id: params.fetch(:id).to_s }
    end

    let(:show_model_context) do
      Interactor::Context.new(errors: :val, model: game_night)
    end

    before do
      allow(ShowModel).to receive(:call).with(show_model_input).
        and_return(show_model_context)
    end

    context "when called" do
      it "calls the ShowModel Interactor" do
        expect(ShowModel).to receive(:call)
        get :show, params
      end
    end

    context "when ShowModel is a success" do
      it "returns HTTP status 200" do
        get :show, params
        expect(response).to have_http_status(200)
      end

      it "renders the GameNight as JSON" do
        get :show, params
        expect(serialize(game_night)).to eq(response.body)
      end
    end

    context "when ShowModel is a failure" do
      let(:show_model_context) do
        double(:context, errors:   { name: ["invalid"] },
                         success?: false,
                         model:    game_night)
      end

      it "returns HTTP status 404" do
        get :show, params
        expect(response).to have_http_status(404)
      end

      it "renders an error" do
        get :show, params
        expect(json["name"]).to eq(["invalid"])
      end
    end
  end

  describe "DELETE #destroy" do
    let(:params) { { id: game_night.id } }
    let(:delete_model_input) do
      { active_record_class: GameNight, id: params.fetch(:id).to_s }
    end

    let(:delete_model_context) do
      Interactor::Context.new(errors: :val, model: game_night)
    end

    before do
      allow(DeleteModel).to receive(:call).with(delete_model_input).
        and_return(delete_model_context)
    end

    context "when called" do
      it "calls the DeleteModel Interactor" do
        expect(DeleteModel).to receive(:call)
        delete :destroy, params
      end
    end

    context "when DeleteModel is a success" do
      it "returns HTTP status 204" do
        delete :destroy, params
        expect(response).to have_http_status(204)
      end
    end

    context "when DeleteModel is a failure" do
      let(:delete_model_context) do
        double(:context, success?: false,
                         model:    game_night,
                         errors:   { id: ["invalid"] })
      end

      it "returns HTTP status 500" do
        delete :destroy, params
        expect(response).to have_http_status(500)
      end

      it "renders an error" do
        delete :destroy, params
        expect(json["id"]).to eq(["invalid"])
      end
    end
  end
end
