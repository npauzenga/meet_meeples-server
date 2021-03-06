RSpec.describe UsersController do
  include Committee::Test::Methods

  let(:user) { create(:unconfirmed_user) }
  let(:schema_path) { "#{Rails.root}/config/schema/api.json" }
  let(:last_response) { response }
  let(:last_request) { request }

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

      it "renders the JWT as json" do
        post :create, params
        expect(json["jwt"]).to include("token")
      end

      it "conforms to JSON schema" do
        post :create, params
        assert_schema_conform
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
        expect(json["email"]).to eq(["error"])
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

      it "returns HTTP status 204" do
        delete :destroy, params
        expect(response).to have_http_status(204)
      end
    end

    context "when DeleteUser fails" do
      let(:delete_user_context) do
        double(:context, errors: "invalid", success?: false)
      end

      it "renders an error" do
        delete :destroy, params
        expect(response.body).to eq("invalid")
      end

      it "returns HTTP status 500" do
        delete :destroy, params
        expect(response).to have_http_status(500)
      end
    end
  end

  describe "PATCH #update" do
    let(:user)   { create(:confirmed_user) }
    let(:params) do
      { id: user.id, user: update_user_input.fetch(:user_params) }
    end

    let(:update_user_input) do
      { user:        user,
        user_params: {
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

      it "renders the user as json" do
        post :update, params
        expect(serialize(user)).to eq(response.body)
      end

      it "conforms to JSON schema" do
        post :update, params
        assert_schema_conform
      end
    end

    context "when Update User fails" do
      let(:update_user_context) do
        double(:context, success?: false, user: user)
      end

      it "renders an error" do
        user.errors.add(:email, "error")
        patch :update, params
        expect(json["email"]).to eq(["error"])
      end

      it "returns HTTP status 500" do
        patch :update, params
        expect(response).to have_http_status(422)
      end
    end
  end
end
