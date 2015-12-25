RSpec.describe PasswordResetsController do
  describe "POST #create" do
    let(:user)      { create(:confirmed_user) }
    let(:params)    { { password_reset: { email: user.email } } }
    let(:arguments) { { email: user.email } }
    let(:context)   { double(:context, success?: true) }

    before(:example) do
      allow(PasswordResetOrganizer).to receive(:call).with(arguments).
        and_return(context)

      allow(context).to receive(:message).and_return(["reset sent"])
      allow(context).to receive(:errors).and_return(["reset failed"])
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

      it "renders a success notice" do
        post :create, params
        expect(JSON.parse(response.body)).to eq(["reset sent"])
      end
    end

    context "when unsuccessful" do
      let(:context) { double(:context, success?: false) }

      it "returns HTTP status 404" do
        post :create, params
        expect(response).to have_http_status(404)
      end

      it "renders an error" do
        post :create, params
        expect(JSON.parse(response.body)).to eq(["reset failed"])
      end
    end
  end

  describe "PATCH #udpate" do
    let(:user)      { create(:confirmed_user) }
    let(:params)    do
      {
	id: "token123", 
	user: { password:  user.password } 
      }
    end

    let(:arguments) { { password: params[:user][:password], token: params[:id] } }
    let(:context)   { double(:context, success?: true) }

    before(:example) do
      allow(UpdatePasswordOrganizer).to receive(:call).with(arguments).
        and_return(context)
      
      allow(context).to receive(:message).and_return(["password updated"])
      allow(context).to receive(:errors).and_return(["update failed"])
    end

    it "calls UpdatePassword interactor" do
      expect(UpdatePasswordOrganizer).to receive(:call)
      patch :update, params
    end

    context "when successful" do
      it "returns HTTP status 200" do
        patch :update, params
        expect(response).to have_http_status(200)
      end

      it "renders a success notice" do
        patch :update, params
        expect(JSON.parse(response.body)).to eq(["password updated"])
      end
    end

    context "when unsuccessful" do
      let(:context) { double(:context, success?: false) }

      it "returns HTTP status 500" do
        patch :update, params
        expect(response).to have_http_status(500)
      end

      it "renders an error" do
        patch :update, params
        expect(JSON.parse(response.body)).to eq(["update failed"])
      end
    end
  end
end
