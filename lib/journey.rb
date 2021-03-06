class Journey
  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1.00
  PENALTY_FARE = 6.00

  def initialize(station = nil)
    @entry_station = station
    @exit_station = nil
    @fare = MINIMUM_FARE
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def fare
    @fare = in_journey? ? PENALTY_FARE : MINIMUM_FARE
  end

  def in_journey?
    @entry_station.nil? || @exit_station.nil?
  end

end
