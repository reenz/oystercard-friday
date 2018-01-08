class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Cannot top up by £#{amount} as your balance will exceed £#{BALANCE_LIMIT}" if balance + amount > BALANCE_LIMIT
    @balance += amount
  end


end
