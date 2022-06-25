class Pangram
  ALPHABET = 'a'..'z'
  REGULAR_EXPRESSIONS = {
    letters: /[a-zA-Z]/
  }

  RE = REGULAR_EXPRESSIONS

  private_constant :ALPHABET,
                   :RE,
                   :REGULAR_EXPRESSIONS

  def self.pangram?(sentence)
    sorted_letters_used = sentence
                          .downcase
                          .scan(RE[:letters])
                          .uniq
                          .sort

    sorted_letters_used == [*ALPHABET]
  end
end
