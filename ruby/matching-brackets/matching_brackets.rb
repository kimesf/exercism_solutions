# class Brackets
#   REGEX = {
#     brackets: /[(){}\[\]]/
#   }

#   TYPES = {
#     '{' => '}',
#     '(' => ')',
#     '[' => ']'
#   }.freeze

#   OPENERS = TYPES.keys.freeze

#   private_constant :OPENERS,
#                    :REGEX,
#                    :TYPES

#   def self.paired?(phrase)
#     brackets = phrase.scan(REGEX[:brackets])
#     stack = []

#     brackets.each do |bracket|
#       next  stack << bracket if OPENERS.include?(bracket)
#       break stack << :error  if TYPES[stack.last] != bracket

#       stack.pop
#     end

#     stack.empty?
#   end
# end

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

  public

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
end
