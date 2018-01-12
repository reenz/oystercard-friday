require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :journeys

  BALANCE_LIMIT = 90.00

  def initialize(journey_class = Journey)
    @balance = 0.00
    @journeys = []
    @journey_class = journey_class
  end

  def top_up(amount)
    message = "£#{amount} top up failed, balance will exceed £#{BALANCE_LIMIT}"
    raise message if maximum_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient balance' if balance_too_low
    @current_journey = @journey_class.new(station)
    @journeys << @current_journey
    deduct(@current_journey.fare) if @current_journey
  end

  def touch_out(station)
    @current_journey = @journey_class.new unless @current_journey
    @current_journey.finish(station)
    deduct(@current_journey.fare)
  end

  def in_journey?
    return false if @current_journey == nil
    @current_journey.in_journey?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def balance_too_low
    @balance < Journey::MINIMUM_FARE
  end

  def maximum_exceeded?(amount)
    @balance + amount > BALANCE_LIMIT
  end

end
