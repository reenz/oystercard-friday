class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    message = "£#{amount} top up failed, balance will exceed £#{BALANCE_LIMIT}"
    raise message if maximum_exceeded?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private
  def maximum_exceeded?(amount)
    balance + amount > BALANCE_LIMIT
  end

end
