class Sieve
  attr_reader :primes

  private

  attr_reader :record, :limit

  def initialize(limit)
    @primes = []
    @limit = limit
    @record = (2..limit).each_with_object({}) { |num, hash| hash[num] = :unmarked }

    calculate_primes
  end

  def calculate_primes
    record.each do |maybe_prime, value|
      next if value == :marked

      @primes << maybe_prime
      mark_multiples_of(maybe_prime)
    end
  end

  def mark_multiples_of(key)
    multiplication_table_of(key)
      .take_while { _1 <= limit}
      .each { record[_1] = :marked }
  end

  def multiplication_table_of(num) = (1..).lazy.map { num * _1 }
end
