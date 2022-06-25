class Isogram
  LETTERS_REGEX = /\w/.freeze
  
  def self.isogram?(word)
    word
      .downcase
      .scan(LETTERS_REGEX)
      .group_by(&:itself)
      .transform_values(&:count)
      .none? { |_letter, count| count > 1 }
  end
end