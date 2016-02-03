require "rails_helper"

RSpec.describe User do
  required_props = %i(
    first_name
    last_name
    email
    city
    state
    country
    password
  )

  properties = required_props + %i(
    password_digest
    email_confirmed
    confirm_digest
    reset_digest
    reset_sent_at
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
      it "rejects a new user without a `#{prop}`" do
        user = FactoryGirl.build(:unconfirmed_user)
        user.send("#{prop}=", nil)
        expect(user.save).to be_falsy
      end
    end

    it "validates password length" do
      user = FactoryGirl.build(:unconfirmed_user, password: "xxx")
      expect(user.save).to be_falsy
    end

    it "valudates email format" do
      user = FactoryGirl.build(:unconfirmed_user, email: "xxx.xxx")
      expect(user.save).to be_falsy
    end
  end
end
