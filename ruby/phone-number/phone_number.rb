class InvalidPhoneNumber < StandardError; end

class PhoneNumber
  REGULAR_EXPRESSIONS = {
    only_numbers: /[0-9]/
  }

  NANP = {
    i18n_code: 1,
    allowed_first_digits: (2..9),
    area_code_length: 3,
    local_number_length: 7,
    length_with_i18n_code: 11,
    length_without_i18n_code: 10
  }.freeze

  RE = REGULAR_EXPRESSIONS

  private_constant :NANP, :RE, :REGULAR_EXPRESSIONS

  def self.clean(dirty_number)= new(dirty_number).number

  private

  attr_reader :digits, :i18n_code, :area_code, :local_number, :length

  def initialize(dirty_number)
    @digits = dirty_number.scan(RE[:only_numbers]).map(&:to_i)
    @length = digits.length
    @i18n_code = NANP[:i18n_code]

    catalog
  end

  def catalog
    digits_dup = digits.dup

    @i18n_code    = digits_dup.shift if length == NANP[:length_with_i18n_code]
    @area_code    = digits_dup.first(NANP[:area_code_length])
    @local_number = digits_dup.last(NANP[:local_number_length])
  end

  def valid_length?
    NANP.values_at(:length_without_i18n_code, :length_with_i18n_code).include?(length)
  end

  def valid_i18n_code?
    i18n_code == NANP[:i18n_code]
  end

  def valid_first_digits?
    [area_code, local_number].all? { |numbers| NANP[:allowed_first_digits].include?(numbers.first) }
  end

  public

  def number
    return unless valid_length? &&
                  valid_i18n_code? &&
                  valid_first_digits?

    digits.last(10).join
  end
end
