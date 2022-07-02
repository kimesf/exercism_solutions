class Palindromes
  private

  class Product
    attr_reader :value, :factors

    private

    def initialize(value, factors)
      @value = value
      @factors = factors
    end
  end

  attr_reader :factors

  def initialize(max_factor:, min_factor: 1)
    @factors = [*min_factor..max_factor].repeated_combination(2)
  end

  def valid?(number)
    chars = number.to_s

    chars == chars.reverse
  end

  def valid_products
    factors.each_with_object({}) do |factors, result|
      product = factors.inject(&:*)
      next unless valid? product

      result[product] ||= []
      result[product] << factors
    end
  end

  public

  attr_reader :largest, :smallest

  def generate
    @smallest, @largest = valid_products.minmax.map { |attrs| Product.new(*attrs) }
  end
end
