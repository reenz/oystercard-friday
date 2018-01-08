require 'oystercard'

describe Oystercard do
  subject :oystercard  { described_class.new }

  context "balance checks:" do
    it "check oystercard balance" do
      expect(oystercard.balance).to eq 0
    end

    it "check top up adds to balance" do
      expect(oystercard.top_up(2)).to eq 2
    end

    it "check top up amount adds same amount to balance" do
      expect{oystercard.top_up(1)}.to change{ oystercard.balance}.by 1
    end

    it "check top up is capped" do
      max_balance = Oystercard::BALANCE_LIMIT
      amount = max_balance + 1
      expect{oystercard.top_up(amount)}.to raise_error "£#{amount} top up failed, balance will exceed £#{max_balance}"
    end

    it "should deduct specified amount from balance" do
      oystercard.top_up(10)
      expect(oystercard.deduct(3)).to eq 7
    end

    it "should deduct specified amount from balance 2" do
      oystercard.top_up(10)
      expect{oystercard.deduct(5)}.to change{ oystercard.balance}.by -5
    end

  end
end
