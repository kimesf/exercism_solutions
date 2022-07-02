module Prime
  def self.nth(nth)
    raise ArgumentError unless nth.positive?

    primes = []

    (2..).each do |number|
      next if compound?(number, primes)

      primes << number

      break if primes.count == nth
    end

    primes.last
  end

  private_class_method def self.compound?(number, primes)
    primes.any? do |prime|
      break if prime**2 > number

      (number % prime).zero?
    end
  end
end
