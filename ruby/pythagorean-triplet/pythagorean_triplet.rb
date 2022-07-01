class Triplet
  def self.where(max_factor:, sum: nil, min_factor: 1)
    triplet_combinations = (min_factor..max_factor).to_a.combination(3)

    triplet_combinations.with_object([]) do |(a, b, c), result|
      next if sum && a + b + c != sum

      result << new(a, b, c) if pythagorean?(a, b, c)
    end
  end

  def self.pythagorean?(a, b, c)= a**2 + b**2 == c**2

  private

  attr_reader :values

  def initialize(*values)
    @values = values
  end

  public

  def sum = values.sum

  def product = values.inject(&:*)

  def pythagorean? = self.class.pythagorean?(*values)
end
