require 'oystercard'

describe Oystercard do
  subject :oystercard  { described_class.new }
  it "check oystercard balance" do
    expect(oystercard.balance).to eq 0
  end

  it "check top up adds to balance" do
    expect(oystercard.top_up(2)).to eq 2

  end

  it "check top up amount adds same amount to balance" do
      expect{oystercard.top_up(1)}.to change{ oystercard.balance}.by 1
    end


end
