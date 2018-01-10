require 'oystercard'

describe Oystercard do
  subject :card  { described_class.new }
  let(:station0) { double :station }
  let(:station1) { double :station }
  let(:station2) { double :station }
  let(:station3) { double :station }

  describe 'stores multiple journeys' do

    it "journeys starts empty" do
      expect(card.journeys).to eq []
    end

    context 'taking the journeys' do
      before do
        card.top_up(10)
        card.touch_in(station0)
        card.touch_out(station1)
      end

      it 'first journey is stored' do
        journey = [{ entry_station: station0, exit_station: station1 }]
        expect(card.journeys).to eq journey
      end

      it 'second journey is stored after first' do
        card.touch_in(station2)
        card.touch_out(station3)
        journey = [
          { entry_station: station0, exit_station: station1 },
          { entry_station: station2, exit_station: station3 }
        ]
        expect(card.journeys).to eq journey
      end

    end

  end

end
