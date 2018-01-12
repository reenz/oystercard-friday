require 'oystercard'

describe Oystercard do
  let(:journey) { double :journey, touch_in: :station, touch_out: :station, fare: 1 }
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

  describe '#in_journey?' do

    it 'returns false before any touches' do
      expect( card ).to_not be_in_journey
    end

  end

  describe '#touch_in' do

    it "raises an error if balance is below 1" do
      #allow(journey).to receive(:new).and_return(journey)
      error = 'Insufficient balance'
      expect { card.touch_in(station0)} .to raise_error error
    end

  end

  describe '#touch_out' do

    before do
      card.top_up(10)
      card.touch_in(station0)
    end

    it "reduces balance by 1" do
      charge = -1
      expect { card.touch_out(station1) } .to change { card.balance } .by charge
    end

  end

end
