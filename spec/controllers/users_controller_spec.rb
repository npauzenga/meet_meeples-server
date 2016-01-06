include Helpers

RSpec.describe UsersController do
  let(:user) { create(:unconfirmed_user) }

  describe "POST #create" do
    let(:params) { { user: create_user_input.fetch(:user_params) } }

    let(:create_user_input) do
      { user_params: {
        first_name: user.first_name,
        email:      user.email,
        last_name:  user.last_name,
        city:       user.city,
        state:      user.state,
        country:    user.country,
        password:   user.password }
      }
    end

    let(:create_auth_token_input) { { user: user } }

    let(:create_user_context) do
      Interactor::Context.new(errors: :val, user: user)
    end

    let(:create_auth_token_context) do
      Interactor::Context.new(errors: :val, token: "token")
    end

    before(:example) do
      allow(CreateUser).to receive(:call).with(create_user_input).
        and_return(create_user_context)

      allow(CreateAuthToken).to receive(:call).with(create_auth_token_input).
        and_return(create_auth_token_context)
    end

    context "when called" do
      it "calls the CreateUser interactor" do
        expect(CreateUser).to receive(:call)
        post :create, params
      end
    end

    context "when CreateUser is a success" do
      it "calls the CreateAuthToken interactor" do
        expect(CreateAuthToken).to receive(:call)
        post :create, params
      end

      it "returns HTTP status 201" do
        post :create, params
        expect(response).to have_http_status(201)
      end
    end

    context "when CreateUser is a failure" do
      let(:create_user_context) do
        double(:context, success?: false, user: user)
      end

      before(:example) do
        allow(CreateUser).to receive(:call).with(create_user_input).
          and_return(create_user_context)
      end

      it "returns HTTP status 422" do
        post :create, params
        expect(response).to have_http_status(422)
      end

      it "returns an error" do
        user.errors.add(:email, "error")
        post :create, params
        expect(JSON.parse(response.body)).to eq("email" => ["error"])
      end
    end
  end

  describe "GET #show" do
    let(:user)            { create(:confirmed_user) }
    let(:params)          { { id: user.id } }
    let(:show_user_input) { { id: params.fetch(:id).to_s } }

    let(:show_user_context) do
      Interactor::Context.new(errors: :val, user: user)
    end

    before(:example) do
      allow(ShowUser).to receive(:call).with(show_user_input).
        and_return(show_user_context)
    end

    before do
      authenticate
    end

    context "when succesful" do
      let(:serializer) { UserSerializer.new(user) }

      let(:serialization) do
        ActiveModel::Serializer::Adapter.create(serializer)
      end

      it "calls the ShowUser interactor" do
        expect(ShowUser).to receive(:call)
        get :show, params
      end

      it "returns HTTP status 200" do
        get :show, params
        expect(response).to have_http_status(200)
      end

      it "render the user as JSON" do
        get :show, params
        expect(serialization.to_json).to eq(response.body)
      end
    end

    context "when ShowUser fails" do
      let(:show_user_context) do
        double(:context, error: "invalid", success?: false)
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

  describe "DELETE #destroy" do
    let(:user)              { create(:confirmed_user) }
    let(:params)            { { id: user.id } }
    let(:delete_user_input) { { id: params.fetch(:id) } }

    let(:delete_user_context) do
      Interactor::Context.new(errors: :val, user: user)
    end

    before(:example) do
      allow(DeleteUser).to receive(:call).with(delete_user_input).
        and_return(delete_user_context)
    end

    before do
      authenticate
    end

    context "when successful" do
      it "calls the DeleteUser interactor" do
        expect(DeleteUser).to receive(:call)
        delete :destroy, params
      end

      it "returns HTTP status 200" do
        delete :destroy, params
        expect(response).to have_http_status(200)
      end
    end

    context "when DeleteUser fails" do
      let(:delete_user_context) do
        double(:context, error: "invalid", success?: false)
      end

      it "renders an error" do
        delete :destroy, params
        expect(response.body).to eq("invalid")
      end

      it "returns HTTP status 404" do
        delete :destroy, params
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "PATCH #update" do
    let(:user)   { create(:confirmed_user) }
    let(:params) { { id: user.id, user: update_user_input.fetch(:params) } }

    let(:update_user_input) do
      { user:   user,
        params: {
          first_name: user.first_name,
          email:      user.email,
          last_name:  user.last_name,
          city:       user.city,
          state:      user.state,
          country:    user.country,
          password:   user.password }
      }
    end

    let(:update_user_context) do
      Interactor::Context.new(errors: :val, user: user)
    end

    before(:example) do
      allow(UpdateUser).to receive(:call).with(update_user_input).
        and_return(update_user_context)
    end

    before do
      authenticate
    end

    context "when successful" do
      it "calls the UpdateUser interactor" do
        expect(UpdateUser).to receive(:call)
        patch :update, params
      end

      it "returns HTTP status 200" do
        patch :update, params
        expect(response).to have_http_status(200)
      end
    end

    context "when Update User fails" do
      let(:update_user_context) do
        double(:context, error: "invalid", success?: false)
      end

      it "renders an error" do
        patch :update, params
        expect(response.body).to eq("invalid")
      end

      it "returns HTTP status 500" do
        patch :update, params
        expect(response).to have_http_status(422)
      end
    end
  end
end
