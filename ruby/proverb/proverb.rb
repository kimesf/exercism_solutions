class Proverb
  VERSES = {
    common: 'For want of a %<missing>s the %<lost>s was lost.',
    final: 'And all for the want of a %<to_blame>s.'
  }

  attr_reader :to_s

  private

  def initialize(*words, qualifier: nil)
    @to_s = verses(words, qualifier)
  end

  def verses(words, qualifier)
    words
      .each_cons(2)
      .map { |missing, lost| common_verse(missing, lost) }
      .push(final_verse(words.first, qualifier))
      .join("\n")
  end

  def common_verse(missing, lost) = format(VERSES[:common], lost:, missing:)

  def final_verse(word, qualifier)
    to_blame = qualifier.nil? ? word : "#{qualifier} #{word}"

    format VERSES[:final], to_blame:
  end
end
