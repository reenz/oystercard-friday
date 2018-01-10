require 'oystercard'
require 'journey'

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

    context 'taking the first journey' do
      before do
        card.top_up(10)
        card.touch_in(station0)
        card.touch_out(station1)
      end

      it 'first journey entry station is stored' do
        expect(card.journeys[0].entry_station).to eq station0
      end

      it 'first journey exit station is stored' do
        expect(card.journeys[0].exit_station).to eq station1
      end

      context 'taking the second journey' do
        before do
          card.touch_in(station2)
          card.touch_out(station3)
        end

        it 'second journey entry station is stored' do
          expect(card.journeys[1].entry_station).to eq station2
        end

        it 'second journey exit station is stored' do
          expect(card.journeys[1].exit_station).to eq station3
        end

      end

    end

  end

end
