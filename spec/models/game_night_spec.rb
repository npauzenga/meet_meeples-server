RSpec.describe GameNight do
  required_props = %i(
    time
    location_name
  )

  properties = required_props + %i(
    location_address
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
      it "rejects a new GameNight without a #{prop}" do
        game_night = FactoryGirl.build(:game_night)
        game_night.send("#{prop}=", nil)
        expect(game_night.save).to be_falsy
      end
    end
  end

  describe "associations" do
    let(:user1)      { create(:confirmed_user) }
    let(:user2)      { create(:confirmed_user) }
    let(:group)      { create(:group) }

    let(:game_night) do
      create(:game_night, group_id: group.id, organizer_id: user1.id)
    end

    before do
      UserGameNightAttendance.create(user_id:       user1.id,
                                   game_night_id: game_night.id)

      UserGameNightAttendance.create(user_id:       user2.id,
                                   game_night_id: game_night.id)
    end

    it "belongs to group" do
      expect(game_night.group).to be_a(Group)
    end

    it "has many user_game_night_attendances" do
      expect(game_night.user_game_night_attendances.count).to eq(2)
    end

    it "has many users through user_game_night_attendances" do
      expect(game_night.users.count).to eq(2)
    end

    it "has one organizer" do
      expect(game_night.organizer).to eq(user1)
    end
  end
end
