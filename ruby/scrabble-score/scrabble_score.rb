class Scrabble
  ZERO_SCORE = 0
  SCORE_DICTIONARY = {
    1  => /[AEIOULNRST]/,
    2  => /[DG]/,
    3  => /[BCMP]/,
    4  => /[FHVWY]/,
    5  => /[K]/,
    8  => /[JX]/,
    10 => /[QZ]/
  }.freeze

  def self.score(text)
    new(text).score
  end
  
  def initialize(text)
    @text = text&.upcase
  end

  def score
    return ZERO_SCORE if @text.nil?
    
    SCORE_DICTIONARY.sum do |score, regex_rule|
      @text.scan(regex_rule).count * score
    end
  end
end