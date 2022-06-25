class Triangle
  TYPES_BY_DIFFERENT_LENGTH_SIDES = {
    equilateral: [:==, 1],
    isosceles: [:<=, 2],
    scalene: [:==, 3]
  }.freeze

  INEQUALITY_RULES = {
    length: ->(sides_lenghts) { sides_lenghts.max < sides_lenghts.sum - sides_lenghts.max }
  }.freeze

  private_constant :INEQUALITY_RULES, :TYPES_BY_DIFFERENT_LENGTH_SIDES

  private

  attr_reader :sides_length

  def initialize(sides_length)
    @sides_length = sides_length
  end

  def sides_with_same_length_count
    sides_length.uniq.count
  end

  def valid?
    INEQUALITY_RULES[:length].call(sides_length)
  end

  public

  TYPES_BY_DIFFERENT_LENGTH_SIDES.each do |name, rule|
    define_method(:"#{name}?") { valid? && sides_with_same_length_count.public_send(*rule) }
  end
end
