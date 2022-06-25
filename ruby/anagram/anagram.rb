class Anagram
  private

  attr_reader :actual_nominee,
              :actual_reference,
              :comparable_nominee,
              :comparable_reference

  def initialize(word)
    normalize(word, :@actual_reference, :@comparable_reference)
  end

  def normalize(word, actual, comparable)
    word = word.downcase

    instance_variable_set(actual, word)
    instance_variable_set(comparable, word.chars.sort)
  end

  def different_word?
    actual_nominee != actual_reference
  end

  def same_letters?
    comparable_nominee == comparable_reference
  end

  def nominee_anagram_to_reference?
    different_word? && same_letters?
  end

  public

  def match(words_ary)
    words_ary.filter do |word|
      normalize(word, :@actual_nominee, :@comparable_nominee)

      nominee_anagram_to_reference?
    end
  end
end
