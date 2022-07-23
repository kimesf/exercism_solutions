class Allergies
  DB_BY_INDEX = %w[
    eggs
    peanuts
    shellfish
    strawberries
    tomatoes
    chocolate
    pollen
    cats
  ]

  private_constant :DB_BY_INDEX

  def list = me

  def allergic_to?(something) = me.include?(something)

  private

  attr_reader :me

  def initialize(score)
    ids = ScoreTranslator.new(score).ids

    @me = get_allergies(ids)
  end

  def get_allergies(ids)
    ids.filter_map { |id| get_allergy(id) }
  end

  def get_allergy(id) = DB_BY_INDEX[id]

  ScoreTranslator = Struct.new(:me) do
    def ids = indexes_where_binary_true(binary_representation)

    private

    def binary_representation
      me
        .to_s(2)
        .chars
        .reverse
    end

    def indexes_where_binary_true(binary_list)
      binary_list
        .each_with_index
        .filter_map { |char, index| index if char == '1' }
    end
  end
end
