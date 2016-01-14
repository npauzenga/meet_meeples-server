RSpec.describe GroupsController do
  let(:user) { create(:confirmed_user) }
  let(:group) { create(:group) }

  before do
    authenticate
  end

  describe "POST #create" do
    let(:params) { { group: create_group_input } }

    let(:create_group_input) do
      { name: group.name }
    end

    let(:create_group_context) do
      Interactor::Context.new(errors: :val, group: group)
    end

    before do
      allow(CreateGroup).to receive(:call).with(create_group_input).
        and_return(create_group_context)
    end

    context "when called" do
      it "calls the CreateGroup interactor" do
        expect(CreateGroup).to receive(:call)
        post :create, params
      end
    end

    context "when CreateGroup is a success" do
      let(:serializer) { GroupSerializer.new(group) }

      let(:serialization) do
        ActiveModel::Serializer::Adapter.create(serializer)
      end

      it "returns HTTP status 201" do
        post :create, params
        expect(response).to have_http_status(201)
      end

      it "renders the group as JSON" do
        post :create, params
        expect(serialize(group)).to eq(response.body)
      end
    end

    context "when CreateGroup is a failure" do
      let(:create_group_context) do
        double(:context, success?: false, group: group)
      end

      it "returns HTTP status 422" do
        post :create, params
        expect(response).to have_http_status(422)
      end

      it "returns an error" do
        group.errors.add(:name, "error")
        post :create, params
        expect(json["name"]).to eq(["error"])
      end
    end
  end

  describe "GET #show" do
    let(:group) { create(:group) }
    let(:params) { { id: group.id } }
    let(:show_group_input) { { id: params.fetch(:id).to_s } }

    let(:show_group_context) do
      Interactor::Context.new(errors: :val, group: group)
    end

    before do
      allow(ShowGroup).to receive(:call).with(show_group_input).
        and_return(show_group_context)
    end

    context "when called" do
      it "calls the ShowGroup Interactor" do
        expect(ShowGroup).to receive(:call)
        get :show, params
      end
    end

    context "when ShowGroup is successful" do
      it "returns HTTP status 200" do
        get :show, params
        expect(response).to have_http_status(200)
      end

      it "renders the group as JSON" do
        get :show, params
        expect(serialize(group)).to eq(response.body)
      end
    end

    context "when ShowGroup is a failure" do
      let(:show_group_context) do
        double(:context,
               errors:   { name: ["invalid"] },
               success?: false,
               group:    group)
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

  describe "PATCH #update" do
    let(:params) { { id: group.id, group: update_group_input } }

    let(:update_group_input) do
      { name: group.name }
    end

    let(:update_group_context) do
      Interactor::Context.new(errors: :val, group: group)
    end

    before do
      allow(UpdateGroup).to receive(:call).with(update_group_input).
        and_return(update_group_context)
    end

    context "when called" do
      it "calls the UpdateGroup Interactor" do
        expect(UpdateGroup).to receive(:call)
        patch :update, params
      end
    end

    context "when UpdateGroup is successful" do
      it "returns HTTP status 200" do
        patch :update, params
        expect(response).to have_http_status(200)
      end

      it "renders the group as JSON" do
        patch :update, params
        expect(serialize(group)).to eq(response.body)
      end
    end

    context "when UpdateGroup is a failure" do
      let(:update_group_context) do
        double(:context, success?: false, group: group)
      end

      it "returns HTTP status 422" do
        patch :update, params
        expect(response).to have_http_status(422)
      end

      it "renders an error" do
        group.errors.add(:name, "error")
        patch :update, params
        expect(json["name"]).to eq(["error"])
      end
    end
  end

  describe "DELETE #destroy" do
    let(:params) do
      { id: group.id }
    end

    let(:delete_group_input) do
      { id: params.fetch(:id).to_s }
    end

    let(:delete_group_context) do
      Interactor::Context.new(errors: :val, group: group)
    end

    before do
      allow(DeleteGroup).to receive(:call).with(delete_group_input).
        and_return(delete_group_context)
    end

    context "when called" do
      it "calls the DeleteGroup Interactor" do
        expect(DeleteGroup).to receive(:call)
        delete :destroy, params
      end
    end

    context "when DeleteGroup is successful" do
      it "returns HTTP status 200" do
        delete :destroy, params
        expect(response).to have_http_status(200)
      end
    end

    context "when DeleteGroup is a failure" do
      let(:delete_group_context) do
        double(:context,
               errors:   { id: ["invalid"] },
               success?: false,
               group:    group)
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
