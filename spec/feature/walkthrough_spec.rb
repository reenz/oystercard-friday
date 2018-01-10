require 'journey'
describe Journey do
  let(:station) { double :station, zone: 1}

  it "knows if a journey is not complete" do
    expect(subject).not_to be_in_journey
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting a journey" do
    pending "no idea why this should return itself"
    expect(subject.touch_out(station)).to eq(subject)
  end

  context 'given an entry station' do
    subject {described_class.new(entry_station: station)}

    it 'has an entry station' do
      pending "why entry_station: station?"
      expect(subject.entry_station).to eq station
    end

    it "returns a penalty fare if no exit station given" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do
      let(:other_station) { double :other_station }

      before do
        subject.touch_out(other_station)
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq 1
      end

      it "knows if a journey is complete" do
        expect(subject).not_to be_in_journey
      end
    end
  end
end
