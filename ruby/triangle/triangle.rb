require 'forwardable'

class Triangle
  extend Forwardable

  class InequalityRulesValidation
    private

    attr_reader :lengths

    def initialize(lengths)
      @lengths = lengths
    end

    def length?
      larger = lengths.max

      larger < lengths.sum - larger
    end

    public

    def valid?
      length?
    end
  end

  private_constant :InequalityRulesValidation

  private

  attr_reader :lengths

  def initialize(lengths)
    @lengths = lengths
    @validation = InequalityRulesValidation.new(lengths)
  end

  def_delegators :@validation, :valid?

  public

  {
    equilateral?: [:==, 1],
    isosceles?: [:<=, 2],
    scalene?: [:==, 3]
  }.each do |name, rule|
    define_method(name) { valid? && lengths.uniq.count.public_send(*rule) }
  end
end
