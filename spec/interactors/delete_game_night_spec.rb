RSpec.describe DeleteGameNight do
  describe ".call" do
    let(:game_night) { create(:game_night) }

    context "when successful" do
      subject do
        described_class.call(id: game_night.id)
      end

      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "deletes the game_night record" do
        expect(subject.game_night.destroyed?).to be_truthy
      end
    end

    context "when game_night id is invalid" do
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

    context "when destroy fails" do
      before do
        allow_any_instance_of(GameNight).to receive(:destroyed?).
          and_return(false)
      end

      subject do
        described_class.call(id: game_night.id)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("game night not deleted")
      end
    end
  end
end
