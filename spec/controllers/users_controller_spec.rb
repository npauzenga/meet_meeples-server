RSpec.describe UsersController do
  let(:user) { create(:unconfirmed_user) }

  describe "POST #create" do
    let(:params) { { user: create_user_input.fetch(:user_params) } }

    let(:create_user_input) do
      { user_params: {
        first_name: user.first_name,
        email: user.email,
        last_name: user.last_name,
        city: user.city,
        state: user.state,
        country: user.country,
        password: user.password }
      }
    end

    let(:create_auth_token_input) do
      {
        user: user
      }
    end

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

    context "when valid params are provided" do
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

    context "when invalid params are provided" do
      before do
        params = nil
      end

      it "calls the CreateUser interactor" do
        expect(CreateUser).to receive(:call)
        post :create, params
      end
    end

    context "when CreateUser is a failure" do
      let(:create_user_context) { double(:context, success?: false,
                                                   user: user) }

      before(:example) do
        allow(CreateUser).to receive(:call).with(create_user_input).
          and_return(create_user_context)
        end

      it "returns HTTP status 422" do
        post :create, params
        expect(response).to have_http_status(422)
      end

      it "returns an error" do
        user.errors.add(:email, message = "error")
        post :create, params
        expect(JSON.parse(response.body)).to eq({"email"=>["error"]})
      end
    end
  end

  describe "GET #show" do
    let(:user) { create(:confirmed_user) }

    context "when user is signed in" do
      def authenticate
        token = Knock::AuthToken.new(payload: { sub: user.id }).token
        request.env['HTTP_AUTHORIZATION'] = "bearer #{token}"
      end

      before do
        authenticate
      end

      it "calls the ShowUser interactor" do
        get :show
        expect(ShowUser).to receive(:call)
      end
    end

    context "when user is not signed in" do
      it "displays an error" do
        user.errors.add(:email, message = "error")
        get :show
        expect(JSON.parse(response.body)).to eq({"email"=>["error"]})
      end

      it "redirects to sign in" do
        expect(get :show).to redirect_to("/signin")
      end
    end

  end

  describe "DELETE #destroy" do
    context "when user is signed in" do
      it "calls the DeleteUser interactor" do

      end
    end

    context "when user is not signed in" do
      it "displays an error" do

      end

      it "redirects to login" do

      end
    end

  end

  describe "PATCH #update" do
    context "when user is signed in" do
      it "calls the UpdateUser interactor" do

      end
    end

    context "user is not signed in" do
      it "displays an error" do

      end

      it "redirects to login" do

      end
    end
  end
end
