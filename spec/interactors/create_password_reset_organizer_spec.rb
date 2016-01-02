RSpec.describe CreatePasswordResetOrganizer do
  subject { described_class }

  let(:find_user_by_email)          { double("find_user_by_email") }
  let(:create_password_reset_token) { double("create_password_reset_token") }
  let(:send_password_reset_email)   { double("send_password_reset_email") }

  before(:example) do
    allow(FindUserByEmail).to receive(:new).
      and_return(find_user_by_email)
    allow(find_user_by_email).to receive(:run!)
    allow(find_user_by_email).to receive(:run)
    allow(find_user_by_email).to receive(:context)

    allow(CreatePasswordResetToken).to receive(:new).
      and_return(create_password_reset_token)
    allow(create_password_reset_token).to receive(:run!)
    allow(create_password_reset_token).to receive(:run)
    allow(create_password_reset_token).to receive(:context)

    allow(SendPasswordResetEmail).to receive(:new).
      and_return(send_password_reset_email)
    allow(send_password_reset_email).to receive(:run!)
    allow(send_password_reset_email).to receive(:run)
    allow(send_password_reset_email).to receive(:context)
  end

  describe ".call" do
    it "calls the FindUserByEmail interactor" do
      expect(find_user_by_email).to receive(:run!)
      subject.call
    end

    it "calls the CreatePasswordResetToken interactor" do
      expect(create_password_reset_token).to receive(:run!)
      subject.call
    end

    it "calls the SendPasswordResetEmail interactor" do
      expect(send_password_reset_email).to receive(:run!)
      subject.call
    end
  end
end
