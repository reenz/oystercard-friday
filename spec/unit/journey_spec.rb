require 'journey'

describe Journey do
  subject :journey {described_class.new(nil)}
  let(:station0) { double :station }

  it 'is created with an entry station' do
    journey = described_class.new(station0)
    expect(journey.entry_station).to eq station0
  end

  describe '#fare' do
    it "calculates minimum fare of #{Journey::MINIMUM_FARE}" do
      journey.touch_in(station0)
      journey.touch_out(station0)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it "returns penalty fare of #{Journey::PENALTY_FARE} when only touch out" do
      journey.touch_out(station0)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it "returns penalty fare of #{Journey::PENALTY_FARE} when only touch in" do
      journey.touch_in(station0)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

  end
end
