class ResistorColorTrio
  COLORS = %w[black brown red orange yellow green blue violet grey white].freeze
  LABEL = 'Resistor value: %<amount>s %<measure>s'

  private_constant :COLORS, :LABEL

  private

  attr_reader :ohms

  def initialize(colors)
    validate_colors(colors)

    @ohms = calculate_ohms(colors)
  end

  def validate_colors(colors)
    raise ArgumentError unless colors.all? { |color| COLORS.include? color }
  end

  def calculate_ohms(colors)
    ten, unity, zeros_amount = colors.map(&method(:decode_value))

    @ohms = [ten, unity].join.to_i * 10**zeros_amount
  end

  def decode_value(color)= COLORS.find_index(color).to_i

  public

  def label
    amount = ohms
    measure = 'ohms'

    if ohms > 1000
      amount /= 1000
      measure.prepend('kilo')
    end

    format LABEL, amount:, measure:
  end
end
