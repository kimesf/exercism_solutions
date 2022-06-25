module SavingsAccount
  module InterestRates
    RULES = [
      { condition: (-Float::INFINITY...0),   pct: -3.213 },
      { condition: (0...1_000),              pct:  0.5   },
      { condition: (1_000...5_000),          pct:  1.621 },
      { condition: (5_000..Float::INFINITY), pct:  2.475 }
    ].freeze

    def self.for(balance)
      RULES.find { |rule| rule[:condition].include?(balance) }[:pct]
    end
  end

  def self.interest_rate(balance) = InterestRates.for(balance)

  def self.annual_balance_update(balance)
    interest_update = balance.abs * (self.interest_rate(balance) / 100) 
    
    balance + interest_update
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    years = 0
    
    until current_balance.abs >= desired_balance.abs
      current_balance = annual_balance_update(current_balance)
      years += 1
    end

    years
  end
end
