RSpec.describe UpdatePasswordOrganizer do
  subject { described_class }

  let(:find_user_by_reset_token) { double("find_user_by_reset_token") }
  let(:check_token_expiration)   { double("check_token_expiration") }
  let(:update_password)          { double("update_password") }

  before(:example) do
    allow(FindUserByResetToken).to receive(:new).
      and_return(find_user_by_reset_token)
    allow(find_user_by_reset_token).to receive(:run!)
    allow(find_user_by_reset_token).to receive(:run)
    allow(find_user_by_reset_token).to receive(:context)

    allow(CheckTokenExpiration).to receive(:new).
      and_return(check_token_expiration)
    allow(check_token_expiration).to receive(:run!)
    allow(check_token_expiration).to receive(:run)
    allow(check_token_expiration).to receive(:context)

    allow(UpdatePassword).to receive(:new).
      and_return(update_password)
    allow(update_password).to receive(:run!)
    allow(update_password).to receive(:run)
    allow(update_password).to receive(:context)
  end

  describe ".call" do
    it "calls the FindUserByResetToken interactor" do
      expect(find_user_by_reset_token).to receive(:run!)
      subject.call
    end

    it "calls the CheckTokenExpiration interactor" do
      expect(check_token_expiration).to receive(:run!)
      subject.call
    end

    it "calls the UpdatePassword interactor" do
      expect(update_password).to receive(:run!)
      subject.call
    end
  end
end
