class Anagram
  private

  def initialize(word)
    @insensitive_word = word.downcase
    @letters = insensitive_word.chars.sort
  end

  def ==(other)
    insensitive_word == other.insensitive_word
  end

  def =~(other)
    self != other &&
      letters == other.letters
  end

  public

  attr_reader :letters, :insensitive_word

  def match(words_ary)
    words_ary.filter do |word|
      nominee = self.class.new(word)

      self =~ nominee
    end
  end
end
