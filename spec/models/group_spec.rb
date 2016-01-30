RSpec.describe Group do
  required_props = %i(name)

  properties = required_props + %i(
    city
    state
    country
    facebook
    twitter
  )

  describe "properties" do
    properties.each do |prop|
      it "has an accessor for #{prop}" do
        expect { subject.send(prop) }.to_not raise_error
      end
    end
  end

  describe "validations" do
    required_props.each do |prop|
      it "rejects a new group without a `#{prop}`" do
        group = FactoryGirl.build(:group)
        group.send("#{prop}=", nil)
        expect(group.save).to be_falsy
      end
    end
  end

  describe "associations" do
    let(:user1)        { create(:confirmed_user) }
    let(:user2)        { create(:confirmed_user) }
    let(:group)        { create(:group) }

    before do
      UserGroupMembership.create(user_id: user1.id, group_id: group.id)
      UserGroupMembership.create(user_id: user2.id, group_id: group.id)
    end

    it "has many user_group_memberships" do
      expect(group.user_group_memberships.count).to eq(2)
    end

    it "has many users through user_group_memberships" do
      expect(group.users.count).to eq(2)
    end

    it "has many game nights" do
      create(:game_night, group_id: group.id)
      create(:game_night, group_id: group.id)

      expect(group.game_nights.count).to eq(2)
    end
  end
end
