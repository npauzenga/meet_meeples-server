RSpec.describe Group do
  required_props = %i(
    name
    moderator_email
  )

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
end
