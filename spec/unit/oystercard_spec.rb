require 'oystercard'

describe Oystercard do
  subject :card  { described_class.new }
  let(:station0) { double :station }
  let(:station1) { double :station }

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

    it "raises an error if balance is below #{Oystercard::MINIMUM_FARE}" do
      error = 'Insufficient balance'
      expect { card.touch_in(station0)} .to raise_error error
    end

    context 'card ready to use' do

      before do
        card.top_up(10)
      end

      it 'changes oystercard journey status to true' do
        expect { card.touch_in(station0)} .to change { card.in_journey? } .to true
      end

      it "returns station after touch in" do
        expect(card.touch_in(station0)).to eq card.entry_station
      end

    end

  end

  describe '#touch_out' do

    before do
      card.top_up(10)
      card.touch_in(station0)
    end

    it 'changes oystercard journey status to false' do
      expect { card.touch_out(station1) } .to change { card.in_journey? } .to false
    end

    it "reduces balance by #{Oystercard::MINIMUM_FARE}" do
      charge = -Oystercard::MINIMUM_FARE
      expect { card.touch_out(station1) } .to change { card.balance } .by charge
    end

    it "sets entry station to nil on touch out" do
      expect { card.touch_out(station1) } .to change { card.entry_station } .to nil
    end

  end

end
