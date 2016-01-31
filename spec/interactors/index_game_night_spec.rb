RSpec.describe IndexGameNight do
  describe ".call" do
    subject do
      described_class.call
    end

    let!(:game_night1) { create(:game_night) }
    let!(:game_night2) { create(:game_night) }
    let!(:game_night3) { create(:game_night) }

    context "when successful" do
      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "sets game_nights to an array of game_nights" do
        expect(subject.game_nights).to eq([game_night1, game_night2, game_night3])
      end
    end

    context "when unsuccessful" do
      before do
        allow(GameNight).to receive(:all).and_return(nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("internal server error")
      end
    end
  end
end
