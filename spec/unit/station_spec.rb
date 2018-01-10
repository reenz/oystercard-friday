require 'station'

describe Station do
  subject :station {described_class.new(:name,:zone)}

  it "creates a Station object" do
    expect(station.name).to eq :name
  end

  it "creates a Station object" do
    expect(station.zone).to eq :zone
  end
end
