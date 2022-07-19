class Allergies
  BY_INDEX = %w[
    eggs
    peanuts
    shellfish
    strawberries
    tomatoes
    chocolate
    pollen
    cats
  ]

  private_constant :BY_INDEX

  def list
    me
  end

  def allergic_to?(something)
    me.include?(something)
  end

  private

  attr_reader :score_base2, :me

  def initialize(score)
    score_base2 = Number.new(score).base2_reversed_ary
    indexes     = score_to_indexes(score_base2)

    @me = find_allergies(indexes)
  end

  def score_to_indexes(score_base2)
    score_base2
      .each_with_index
      .filter_map { |binary, index| index if binary.nonzero? }
  end

  def find_allergies(indexes)
    indexes.filter_map { |index| allergy_at(index) }
  end

  def allergy_at(index)
    BY_INDEX[index]
  end

  Number = Struct.new(:me) do
    def base2_reversed_ary
      num = me
      digits = []

      while num.positive?
        digits << num % 2
        num /= 2
      end

      digits
    end
  end
end
