require 'oystercard'

describe Oystercard do
  let(:journey) { double :journey, start: :station, finish: :station, fare: 1 ,PENALTY_FARE: 6}
  let(:journey_class) { double :journey_class, new: journey, MINIMUM_FARE: 1}
  subject :card  { described_class.new(journey_class) }
  let(:station0) { double :station }
  let(:station1) { double :station }

    # let(:journey) { double (:journey, stubs={:touch_in => station, :touch_out =>station, :fare =>1 })}
    # let(:journey_class) { class_double "Journey", stubs = {:new => journey, :MINIMUM_FARE => 1})}
    # subject :card  { described_class.new(journey_class) }
    # let(:station0) { double :station }
    # let(:station1) { double :station }

  it "balance should be zero" do
    expect(card.balance).to eq 0
  end

  describe '#top_up' do

    it "top up adds to balance" do
      expect { card.top_up(2) } .to change { card.balance } .by 2
    end

    it "top up will not exceed balance limit" do
      max_balance = Oystercard::BALANCE_LIMIT
      amount = Oystercard::BALANCE_LIMIT + 1
      error = "£#{amount} top up failed, balance will exceed £#{max_balance}"
      expect { card.top_up(amount) } .to raise_error error
    end

  end

  describe '#touch_in' do

    it "raises an error if balance is below 1" do
      error = 'Insufficient balance'
      expect { card.touch_in(station0)} .to raise_error error
    end

    it "charges PENALTY_FARE for not touching out after touch in" do
      card.top_up(10)
      allow(journey).to receive(:fare).and_return 6
      card.touch_in(station0)
      card.touch_in(station1)
      expect(card.balance).to eq 4
    end

    it 'returns a new instance of journey' do
      card.top_up(10)
      expect(card.touch_in(station0)).to eq journey
    end
    it 'creates a new journey if outstanding incomplete journey' do
      card.top_up(10)
      card.touch_in(station0)
      card.touch_in(station1)
      expect(journey_class).to have_received(:new).twice
    end
    it 'store the previous journey if outstanding journey incomplete when touched in ' do
      card.top_up(10)
      card.touch_in(station0)
      card.touch_in(station1)
      expect(card.journeys).to include journey
    end
  end

  describe '#touch_out' do

    it "reduces balance by 1" do
      card.top_up(10)
      card.touch_in(station0)
      charge = -1
      expect { card.touch_out(station1) } .to change { card.balance } .by charge
    end

    it "charges PENALTY_FARE for not touching in before touch out"do
      allow(journey).to receive(:fare).and_return 6
      card.top_up(10)
      card.touch_out(station1)
      expect(card.balance).to eq 4
    end

    it 'clears current journeys to nil' do
      expect(card.touch_out(station1)).to eq nil

    end

    it "checks if new journey is being created on touch out without first touch in" do
      expect(journey_class).to receive(:new)
      card.touch_out(station1)
    end
    it 'creates new journey if touched out twice' do
      card.touch_out(station0)
      card.touch_out(station1)
      expect(journey_class).to have_received(:new).twice
    end
  end

end
