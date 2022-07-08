module BaseConverter
  def self.convert(input_base, digits, output_base)
    Number.new(digits, input_base).to_base(output_base)
  end

  class Number
    ZERO = [0]

    private_constant :ZERO

    def to_base(base)
      validate(base)
      return ZERO if zero?

      remainder = number_base10
      new_digit_weighted_positions(base).map do |weight|
        multiplier = base**weight
        digit      = remainder.div(multiplier)
        remainder -= digit * multiplier

        digit
      end
    end

    private

    attr_reader :number_base10

    def initialize(digits, base)
      validate(base, digits)

      @number_base10 = digits.reverse.each_with_index.sum { |digit, weight| digit * (base**weight) }
    end

    def validate(base, digits = [])
      return if valid_base?(base) && valid_digits?(digits, base)

      raise ArgumentError
    end

    def valid_base?(base)
      base > 1
    end

    def valid_digits?(digits, base)
      digits.none? { |digit| digit.negative? || digit >= base }
    end

    def zero?
      number_base10.zero?
    end

    def new_digit_weighted_positions(base)
      new_digit_size = (0..).find_index { |i| base**i > number_base10 }

      [*0...new_digit_size].reverse
    end
  end

  private_constant :Number
end
