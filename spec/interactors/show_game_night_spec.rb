RSpec.describe ShowGameNight do
  describe ".call" do
    let(:game_night) { create(:game_night) }

    context "when successful" do
      subject do
        described_class.call(id: game_night.id)
      end

      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "returns a valid game_night record" do
        expect(subject.game_night).to be_a GameNight
      end
    end

    context "when invalid id is provided" do
      subject do
        described_class.call(id: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end
  end
end
