class Brackets
  REGEX = {
    brackets: /[(){}\[\]]/
  }

  TYPES = {
    '{' => '}',
    '(' => ')',
    '[' => ']'
  }.freeze

  OPENERS = TYPES.keys.freeze

  private_constant :OPENERS,
                   :REGEX,
                   :TYPES

  def self.paired?(phrase)
    brackets = phrase.scan(REGEX[:brackets])
    stack = []

    brackets.each do |bracket|
      next  stack << bracket if OPENERS.include?(bracket)
      break stack << :error  if TYPES[stack.last] != bracket

      stack.pop
    end

    stack.empty?
  end
end
