include Helpers

RSpec.describe GroupsController do
  let(:group) { create(:group) }
  let(:serializer) { GroupSerializer.new(group) }

  let(:serialization) do
    ActiveModel::Serializer::Adapter.create(serializer)
  end

  before do
    authenticate
  end

  describe "POST #create" do
    let(:params) { { group: create_group_input.fetch(:group_params) } }

    let(:create_group_input) do
      { group_params: {
        name: group.name }
      }
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
        expect(serialization.to_json).to eq(response.body)
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
        group.errors.add("error")
        post :create, params
        expect(JSON.parse(response.body)).to eq("error")
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
      it "returns HTTP status 201" do
        get :show, params
        expect(response).to have_http_status(200)
      end

      it "renders the group as JSON" do
        get :show, params
        expect(serialization.to_json).to eq(response.body)
      end
    end

    context "when ShowGroup fails" do
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

  describe "PATCH #update" do
    context "when called" do
      it "calls the UpdateGroup Interactor" do
      end
    end

    context "when UpdateGroup is successful" do
      it "returns HTTP status 201" do
      end

      it "renders the group as JSON" do
      end
    end

    context "when UpdateGroup fails" do
      it "returns HTTP status xxx" do
      end

      it "renders an error" do
      end
    end
  end

  describe "DELETE #delete" do
  end

  describe "GET #index" do
  end
end
