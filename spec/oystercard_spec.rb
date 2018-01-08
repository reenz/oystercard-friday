require 'oystercard'
describe Oystercard do
  subject :oystercard  { described_class.new }
  it "check oystercard balance" do
    expect(oystercard.balance).to eq 0
  end

end
