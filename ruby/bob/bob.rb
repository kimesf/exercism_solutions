class Remark
  QUESTION_MARK = '?'.freeze
  REGULAR_EXPRESSIONS = {
    letters: /[a-zA-Z]/
  }

  RE = REGULAR_EXPRESSIONS

  private_constant :QUESTION_MARK, :REGULAR_EXPRESSIONS, :RE

  private

  attr_reader :phrase, :letters, :chars

  def initialize(phrase)
    phrase = phrase.strip

    @phrase = phrase
    @letters = phrase.scan RE[:letters]
    @chars = phrase.chars
  end

  def question?
    chars.last == QUESTION_MARK
  end

  def yelling?
    letters.any? &&
      letters.all? { |char| char == char.upcase }
  end

  def silence?
    phrase.empty?
  end

  public

  def type
    return :silence         if silence?
    return :yelled_question if yelling? && question?
    return :yell            if yelling?
    return :question        if question?

    :statament
  end
end

class Bob
  ANSWERS_TO = {
    silence: 'Fine. Be that way!',
    question: 'Sure.',
    yell: 'Whoa, chill out!',
    yelled_question: 'Calm down, I know what I\'m doing!',
    statament: 'Whatever.'
  }

  private_constant :ANSWERS_TO

  def self.hey(remark)
    remark = Remark.new(remark)

    ANSWERS_TO[remark.type]
  end
end
