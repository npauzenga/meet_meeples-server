RSpec.describe UsersController do
  let(:user) { create(:unconfirmed_user) }

  describe "POST #create" do
    let(:params) { { user: interactor_input.fetch(:user_params) } }

    let(:interactor_input) do
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

    let(:interactor_context) do
      Interactor::Context.new(errors: :val, user: user)
    end

    before(:example) do
      allow(CreateUser).to receive(:call).with(interactor_input).
        and_return(interactor_context)
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

      it "returns the jwt" do

      end
    end

    context "when invalid params are provided" do
      it "calls the CreateUser interactor" do
        expect(CreateUser).to receive(:call)
        post :create, params
      end
    end

    context "when CreateUser is a failure" do
      it "returns HTTP status 422" do
        post :create, params
        expect(response).to have_http_status(201)
      end

      it "returns an error" do

      end
    end
  end

  describe "GET #show" do

  end

  describe "DELETE #destroy" do

  end
end
