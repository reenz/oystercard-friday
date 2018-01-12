require 'journey'

describe Journey do
  subject :journey { described_class.new }
  let(:station0) { double :station }
  let(:station1) { double :station }

  it 'is created with no stations when created with no arguments' do
    expect(journey.entry_station).to eq nil
    expect(journey.exit_station).to eq nil
  end

  it 'is created with an entry station when given an argument' do
    journey = described_class.new(station0)
    expect(journey.entry_station).to eq station0
  end

  describe '#start' do
    it 'sets entry station when given station as an argument' do
      journey.start(station0)
      expect(journey.entry_station).to eq station0
    end
  end

  describe '#finish' do
    it 'sets exit station when given station as an argument' do
      journey.finish(station1)
      expect(journey.exit_station).to eq station1
    end
  end

  describe '#fare' do
    it "calculates minimum fare of #{Journey::MINIMUM_FARE}" do
      journey.start(station0)
      journey.finish(station0)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it "returns penalty fare of #{Journey::PENALTY_FARE} when only touch out" do
      journey.finish(station0)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it "returns penalty fare of #{Journey::PENALTY_FARE} when only touch in" do
      journey.start(station0)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

  end

  describe '#in_journey?' do

    it 'returns true if only given an entry station' do
      journey.start(station0)
      expect(journey.in_journey?).to eq true
    end

    it 'returns true if only given an exit station' do
      journey.finish(station1)
      expect(journey.in_journey?).to eq true
    end

    it 'returns false when given an entry and exit station' do
      journey.start(station0)
      journey.finish(station1)
      expect(journey.in_journey?).to eq false
    end
  end
end
