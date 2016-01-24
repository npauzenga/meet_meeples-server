RSpec.describe GroupMembershipsController do
  describe "POST #create" do
    let(:user)      { create(:confirmed_user) }
    let(:group)     { create(:group) }
    let(:params)    { { id: group.id } }
    let(:arguments) { { user_id: user.id, group_id: params[:group_id] } }
    let(:context)   { double(:context, success?: true) }

    before(:example) do
      authenticate

      allow(CreateGroupMembership).to receive(:call).with(arguments).
        and_return(context)

      allow(context).to receive(:errors).and_return(["join failed"])
    end

    it "calls CreatePasswordResetOrganizer" do
      expect(CreateGroupMembership).to receive(:call)
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
