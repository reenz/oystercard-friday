class Oystercard

  attr_reader :balance

  BALANCE_LIMIT = 90.00
  MINIMUM_FARE = 1.00

  def initialize
    @balance = 0.00
    @journey_status = false
  end

  def top_up(amount)
    message = "£#{amount} top up failed, balance will exceed £#{BALANCE_LIMIT}"
    raise message if maximum_exceeded?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    balance_error = 'Insufficient balance'
    raise balance_error if balance_too_low
    @journey_status = true
  end

  def touch_out
    @journey_status = false
  end

  def in_journey?
    @journey_status
  end

  private

  def balance_too_low
    @balance < MINIMUM_FARE
  end

  def maximum_exceeded?(amount)
    @balance + amount > BALANCE_LIMIT
  end

end
