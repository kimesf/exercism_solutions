class Luhn
  VALID_LENGTH_RANGE = (2..)
  REGULAR_EXPRESSION = {
    all_but_spaces: /[^\s]/
  }

  TRANSFORM_DIGIT = ->(digit) do
    digit *= 2
    digit -= 9 if digit > 9

    digit
  end

  RE = REGULAR_EXPRESSION

  private_constant :RE,
                   :REGULAR_EXPRESSION,
                   :TRANSFORM_DIGIT,
                   :VALID_LENGTH_RANGE

  def self.valid?(candidate)= new(candidate).valid?

  private

  attr_reader :candidate

  def initialize(candidate)
    @candidate = candidate.scan RE[:all_but_spaces]
  end

  def every_second_digit_from_right
    candidate.reverse.each_with_index.map do |char, index|
      digit = char.to_i
      next digit if index.even?

      yield digit
    end
  end

  def check_to_zero?
    every_second_digit_from_right(&TRANSFORM_DIGIT)
      .sum
      .modulo(10)
      .zero?
  end

  def all_numeric?()= candidate.all? { |digit| Integer(digit, exception: false) }

  def valid_length?()= VALID_LENGTH_RANGE.include?(candidate.size)

  public

  def valid?()= valid_length? && all_numeric? && check_to_zero?
end
