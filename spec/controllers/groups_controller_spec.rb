include Committee::Test::Methods

RSpec.describe GroupsController do
  let(:schema_path)   { "#{Rails.root}/config/schema/api.json" }
  let(:last_response) { response }
  let(:last_request)  { request }

  let(:user) { create(:confirmed_user) }
  let(:group) { create(:group) }

  before do
    authenticate
  end

  describe "POST #create" do
    let(:params) do
      { group: create_group_organizer_input.fetch(:group_params) }
    end

    let(:create_group_organizer_input) do
      {
        user:         user,
        group_params: { name: group.name },
        role:         :moderator
      }
    end

    let(:create_group_organizer_context) do
      Interactor::Context.new(errors: :val, resource: group)
    end

    before do
      allow(CreateGroupOrganizer).to receive(:call).
        with(create_group_organizer_input).
        and_return(create_group_organizer_context)
    end

    context "when called" do
      it "calls the CreateGroup interactor" do
        expect(CreateGroupOrganizer).to receive(:call)
        post :create, params
      end
    end

    context "when CreateGroup is a success" do
      it "returns HTTP status 201" do
        post :create, params
        expect(response).to have_http_status(201)
      end

      it "renders the group as JSON" do
        post :create, params
        expect(serialize(group)).to eq(response.body)
      end

      it "conforms to JSON schema" do
        post :create, params
        assert_schema_conform
      end
    end

    context "when CreateGroup is a failure" do
      let(:create_group_organizer_context) do
        double(:context, success?: false, errors: group.errors, group: group)
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

      it "conforms to JSON schema" do
        get :show, params
        assert_schema_conform
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
    let(:params) do
      { id: group.id, group: update_group_input.fetch(:group_params) }
    end

    let(:update_group_input) do
      { id: group.id.to_s, group_params: { name: group.name } }
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

      it "conforms to JSON schema" do
        patch :update, params
        assert_schema_conform
      end
    end

    context "when UpdateGroup is a failure" do
      let(:update_group_context) do
        double(:context, success?: false, errors: group.errors, group: group)
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

  describe "GET #index" do
    let(:group1) { create(:group) }
    let(:group2) { create(:group) }
    let(:group3) { create(:group) }

    let(:index_group_context) do
      Interactor::Context.new(errors: :val, groups: [group1, group2, group3])
    end

    before(:example) do
      allow(IndexGroup).to receive(:call).and_return(index_group_context)
    end

    before do
      authenticate
    end

    context "when succesful" do
      it "calls the IndexGroup interactor" do
        expect(IndexGroup).to receive(:call)
        get :index
      end

      it "returns HTTP status 200" do
        get :index
        expect(response).to have_http_status(200)
      end

      it "render the groups as JSON" do
        get :index
        expect(json["data"][0].value?(group1.id.to_s)).to be_truthy
        expect(json["data"][1].value?(group2.id.to_s)).to be_truthy
        expect(json["data"][2].value?(group3.id.to_s)).to be_truthy
      end

      it "conforms to JSON schema" do
        get :index
        assert_schema_conform
      end
    end

    context "when IndexGroup fails" do
      let(:index_group_context) do
        double(:context, errors: "internal server error", success?: false)
      end

      it "returns HTTP status 500" do
        get :index
        expect(response).to have_http_status(500)
      end

      it "renders an error" do
        get :index
        expect(response.body).to eq("internal server error")
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
      it "returns HTTP status 204" do
        delete :destroy, params
        expect(response).to have_http_status(204)
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
