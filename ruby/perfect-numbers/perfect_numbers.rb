module PerfectNumber
  def self.classify(integer)
    raise RuntimeError unless integer.positive?

    sum = sum_of_factors(integer)

    return 'abundant'  if sum > integer
    return 'deficient' if sum < integer

    'perfect'
  end

  private_class_method def self.sum_of_factors(integer)
    highest_factor = integer / 2

    (1..highest_factor).filter { |factor| (integer % factor).zero? }.sum
  end
end
