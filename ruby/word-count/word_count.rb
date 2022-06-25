class Phrase
  ALL_WORDS_REGEX = /\w+(?:'\w+)*/.freeze
  private_constant :ALL_WORDS_REGEX 

  attr_reader :word_count
  
  def initialize(text)
    @text = text
  end

  def word_count
    all_words.group_by(&:itself).transform_values(&:count)
  end

  private 
  
  def all_words = @text.downcase.scan(ALL_WORDS_REGEX)
end