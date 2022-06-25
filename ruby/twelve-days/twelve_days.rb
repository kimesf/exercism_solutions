class TwelveDays
  GIFTS_ORDERED_BY_DAY = [
    'Partridge in a Pear Tree',
    'Turtle Doves',
    'French Hens',
    'Calling Birds',
    'Gold Rings',
    'Geese-a-Laying',
    'Swans-a-Swimming',
    'Maids-a-Milking',
    'Ladies Dancing',
    'Lords-a-Leaping',
    'Pipers Piping',
    'Drummers Drumming'
  ].freeze

  ORDINALS          = %w[first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth].freeze
  NUMBERS_HUMANIZED = %w[a two three four five six seven eight nine ten eleven twelve].freeze
  VERSE_TEMPLATE    = "On the %{ordinal} day of Christmas my true love gave to me: %{gifts}.\n"

  def self.song
    verses.join("\n")
  end

  def self.verses
    (0...GIFTS_ORDERED_BY_DAY.count).map do |day_index|
      VERSE_TEMPLATE % {ordinal: ordinalize(day_index), gifts: gifts_at(day_index)}
    end
  end

  def self.gifts_at(day_number)
    gift_list = GIFTS_ORDERED_BY_DAY.values_at(..day_number).each.with_index.map do |gift, qty|
      "#{humanize(qty)} #{gift}"
    end

    to_sentence gift_list.reverse
  end

  def self.humanize(n)= NUMBERS_HUMANIZED[n]

  def self.ordinalize(n)= ORDINALS[n]

  def self.to_sentence(ary)
    return ary.first if ary.one?

    all_but_last = ary[0...-1]
    last = ary[-1]

    [all_but_last.join(", "), ", and ", last].join
  end
end
