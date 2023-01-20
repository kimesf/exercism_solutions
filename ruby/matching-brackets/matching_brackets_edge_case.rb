# Code example for https://github.com/exercism/problem-specifications/pull/2071
class Brackets
  REGEX = {
    brackets: /[(){}\[\]]/
  }

  TYPES = {
    '{' => '}',
    '(' => ')',
    '[' => ']'
  }

  OPENERS = TYPES.keys
  CLOSERS = TYPES.values

  private_constant :CLOSERS,
                   :OPENERS,
                   :REGEX,
                   :TYPES

  def self.paired?(phrase)
    new(phrase).paired?
  end

  def paired?
    brackets.each do |bracket|
      case bracket
      when '{' then count[:braces] += 1
      when '}' then count[:braces] -= 1
      when '(' then count[:parentheses] += 1
      when ')' then count[:parentheses] -= 1
      when '[' then count[:square_brackets] += 1
      when ']' then count[:square_brackets] -= 1
      end

      break if closes_unopened?
      break if closes_wrong?(bracket)

      @last_opened_bracket = nil     if closes_last_opened?(bracket)
      @last_opened_bracket = bracket if opener?(bracket)
    end

    count.values.all?(&:zero?)
  end

  private

  attr_reader :brackets, :count, :last_opened_bracket

  def initialize(phrase)
    @brackets = phrase.scan(REGEX[:brackets])
    @count    = { braces: 0, parentheses: 0, square_brackets: 0 }
  end

  def closes_unopened?
    count.values.any?(&:negative?)
  end

  def closes_wrong?(bracket)
    not_expected_closers = CLOSERS - [closer_for(last_opened_bracket)]

    last_opened_bracket && not_expected_closers.include?(bracket)
  end

  def closer_for(bracket) = TYPES[bracket]

  def opener?(bracket) = OPENERS.include?(bracket)

  def closes_last_opened?(bracket) = bracket == TYPES[last_opened_bracket]
end
