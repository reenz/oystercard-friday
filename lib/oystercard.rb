class Oystercard

  attr_reader :balance, :entry_station

  BALANCE_LIMIT = 90.00
  MINIMUM_FARE = 1.00

  def initialize
    @balance = 0.00
    @entry_station = nil
  end

  def top_up(amount)
    message = "£#{amount} top up failed, balance will exceed £#{BALANCE_LIMIT}"
    raise message if maximum_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    balance_error = 'Insufficient balance'
    raise balance_error if balance_too_low
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def balance_too_low
    @balance < MINIMUM_FARE
  end

  def maximum_exceeded?(amount)
    @balance + amount > BALANCE_LIMIT
  end

end
