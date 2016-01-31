require "rspec_api_documentation/dsl"

RSpec.resource "UserGroupMembership" do
  let(:authenticated_user) do
    create(:confirmed_user)
  end

  let(:auth_token) do
    Knock::AuthToken.new(payload: { sub: authenticated_user.id }).token
  end

  shared_context "user_group_membership parameters" do
    parameter "group_id", <<-DESC, scope: :group, required: true
      The unique id of the group to which the game_night belongs.
    DESC
  end

  post "/groups/:group_id/group_memberships" do
    include_context "game_night parameters"

    let!(:group)    { create(:group) }
    let(:group_id)  { group.id }

    header "Authorization", :auth_token

    example_request "POST /groups/:group_id/group_memberships" do
      expect(status).to eq 204

      expect(authenticated_user.groups.first.name).to eq(group.name)

      expect(group.users.first).to eq authenticated_user
    end
  end
end
