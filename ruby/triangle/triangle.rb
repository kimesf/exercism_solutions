module InequalityRulesValidation
  private

  def valid?
    length?
  end

  def length?
    larger = lengths.max

    larger < lengths.sum - larger
  end
end

class Triangle
  include InequalityRulesValidation

  private

  attr_reader :lengths

  def initialize(lengths)
    @lengths = lengths
  end

  public

  {
    equilateral?: [:==, 1],
    isosceles?: [:<=, 2],
    scalene?: [:==, 3]
  }.each do |name, rule|
    define_method(name) { valid? && lengths.uniq.count.public_send(*rule) }
  end
end
