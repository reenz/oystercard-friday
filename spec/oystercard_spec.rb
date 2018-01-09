require 'oystercard'

describe Oystercard do
  subject :card  { described_class.new }

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

  describe '#deduct' do
    before do
      card.top_up(10)
    end

    it "should deduct amount from balance" do
      expect { card.deduct(3) } .to change { card.balance } .by -3
    end

  end

  describe '#in_journey?' do

    it 'returns false before any touches' do
      expect( card ).to_not be_in_journey
    end

  end

  describe '#touch_in' do

    it 'changes oystercard journey status to true' do
      card.top_up(10)
      expect { card.touch_in } .to change { card.in_journey? } .to true
    end

    it "raises an error if balance is below #{Oystercard::MINIMUM_FARE}" do
      error = 'Insufficient balance'
      expect { card.touch_in } .to raise_error error
    end

  end

  describe '#touch_out' do
    it 'changes oystercard journey status to false' do
      card.top_up(10)
      card.touch_in
      expect { card.touch_out } .to change { card.in_journey? } .to false
    end
  end

end
