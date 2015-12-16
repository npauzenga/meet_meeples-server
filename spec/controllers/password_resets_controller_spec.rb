RSpec.describe PasswordResetsController do
  describe "POST #create" do
    let(:user)      { create(:confirmed_user) }
    let(:params)    { { password_reset: { email: user.email } } }
    let(:arguments) { { email: user.email } }
    let(:context)   { double(:context, success?: true) }

    before(:example) do
      allow(PasswordResetOrganizer).to receive(:call).with(arguments).
        and_return(context)
    end

    it "calls PasswordResetOrganizer" do
      expect(PasswordResetOrganizer).to receive(:call)
      post :create, params
    end

    context "when successful" do
      it "returns HTTP status 201" do
        post :create, params
        expect(response).to have_http_status(201)
      end

      it "redirects to index" do
        post :create, params
        expect(response).to redirect_to("/")
      end

      it "renders a success notice" do
        post :create, params
        expect(JSON.parse(response.body)).to eq(password: ["reset sent"])
      end
    end

    context "when unsuccessful" do
      let(:context)   { double(:context, success?: false) }

      it "returns HTTP status 404" do
        post :create, params
        expect(response).to have_http_status(404)
      end

      it "redirects to index" do
        post :create, params
        expect(response).to redirect_to("/")
      end

      it "renders an error" do
        post :create, params
        expect(JSON.parse(response.body)).to eq(password: ["reset failed"])
      end
    end
  end

  describe "PATCH #udpate" do
    let(:user)      { create(:confirmed_user) }
    let(:params)    { { password_reset: { email: user.email } } }
    let(:arguments) { { user_params: user_params, user: user } }
    let(:context)   { double(:context, success?: true) }

    let(:user_params) do
      { password: user.password }
    end

    before(:example) do
      allow(UpdatePassword).to receive(:call).with(arguments).
        and_return(context)
    end

    it "calls UpdatePassword interactor" do
      expect(UpdatePassword).to receive(:call)
      patch :update, params
    end

    context "when successful" do
      it "returns HTTP status 200" do
        patch :update, params
        expect(response).to have_http_status(200)
      end

      it "redirects to /signin" do
        patch :update, params
        expect(response).to redirect_to("/signin")
      end

      it "renders a success notice" do
        patch :update, params
        expect(JSON.parse(response.body)).to eq(password: ["password updated"])
      end
    end

    context "when unsuccessful" do
      let(:context)   { double(:context, success?: false) }

      it "returns HTTP status 500" do
        patch :update, params
        expect(response).to have_http_status(500)
      end

      it "redirects to index" do
        patch :update, params
        expect(response).to redirect_to("/")
      end

      it "renders an error" do
        patch :update, params
        expect(JSON.parse(response.body)).to eq(password: ["update failed"])
      end
    end
  end
end
