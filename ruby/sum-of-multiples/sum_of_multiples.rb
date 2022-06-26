class SumOfMultiples
  MULTIPLICATION_TABLE = lambda do |integer|
    return [0] if integer.zero?

    (1..).lazy.map { |factor| integer * factor }
  end

  private_constant :MULTIPLICATION_TABLE

  private

  attr_reader :numbers, :limit

  def initialize(*numbers)
    @numbers = numbers
  end

  def multiples_smaller_than_limit(number)
    MULTIPLICATION_TABLE
      .call(number)
      .take_while { _1 < @limit }
      .to_a
  end

  public

  def to(limit)
    @limit = limit

    numbers
      .map(&method(:multiples_smaller_than_limit))
      .flatten
      .uniq
      .sum
  end
end
