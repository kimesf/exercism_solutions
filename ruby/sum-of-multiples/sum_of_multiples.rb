class MultiplicationTable
  def self.of(integer)
    return [0] if integer.zero?

    (1..).lazy.map { |factor| integer * factor }
  end
end

class SumOfMultiples
  private

  attr_reader :numbers, :limit

  def initialize(*numbers)
    @numbers = numbers
  end

  def multiples_smaller_than_limit(number)
    MultiplicationTable
      .of(number)
      .take_while { _1 < @limit }
      .to_a
  end

  def with_limit(limit)
    @limit = limit

    result = yield

    @limit = nil

    result
  end

  public

  def to(limit)
    with_limit(limit) do
      numbers.map(&method(:multiples_smaller_than_limit))
             .flatten
             .uniq
             .sum
    end
  end
end
