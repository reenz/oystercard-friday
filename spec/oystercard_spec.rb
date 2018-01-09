require 'oystercard'

describe Oystercard do
  subject :oystercard  { described_class.new }

  it "balance should be zero" do
    expect(oystercard.balance).to eq 0
  end

  describe '#top_up' do

    it "top up adds to balance" do
      expect { oystercard.top_up(2) } .to change { oystercard.balance } .by 2
    end

    it "top up will not exceed balance limit" do
      max_balance = Oystercard::BALANCE_LIMIT
      amount = Oystercard::BALANCE_LIMIT + 1
      error = "£#{amount} top up failed, balance will exceed £#{max_balance}"
      expect { oystercard.top_up(amount) } .to raise_error error
    end

  end

  describe '#deduct' do
    before do
      oystercard.top_up(10)
    end

    it "should deduct amount from balance" do
      expect { oystercard.deduct(3) } .to change { oystercard.balance } .by -3
    end

  end

end
