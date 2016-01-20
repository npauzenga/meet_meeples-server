RSpec.describe ProfilesController do
  describe "GET #show" do
    let(:user)            { create(:confirmed_user) }
    let(:params)          { { id: user.id } }
    let(:show_profile_input) { { id: params.fetch(:id).to_s } }

    let(:show_profile_context) do
      Interactor::Context.new(errors: :val, user: user)
    end

    before(:example) do
      allow(ShowProfile).to receive(:call).with(show_profile_input).
        and_return(show_profile_context)
    end

    before do
      authenticate
    end

    context "when succesful" do
      it "calls the ShowProfile interactor" do
        expect(ShowProfile).to receive(:call)
        get :show, params
      end

      it "returns HTTP status 200" do
        get :show, params
        expect(response).to have_http_status(200)
      end

      it "render the user as JSON" do
        get :show, params
        expect(serialize(user)).to eq(response.body)
      end
    end

    context "when ShowProfile fails" do
      let(:show_profile_context) do
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
end
