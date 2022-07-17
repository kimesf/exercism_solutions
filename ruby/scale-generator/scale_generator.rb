class Chromatic
  INTERVALS   = ('m' * 12).freeze
  WITH_SHARPS = %w[A A# B C C# D D# E F F# G G#].freeze
  WITH_FLATS  = %w[A Bb B C Db D Eb E F Gb G Ab].freeze
  USE_FLATS   = %w[F Bb Eb Ab Db Gb d g c f bb eb].freeze

  private_constant :USE_FLATS, :WITH_FLATS, :WITH_SHARPS

  def call
    right_chromatic_for_tonic
  end

  private

  attr_reader :tonic

  def initialize(tonic)
    @tonic = tonic
  end

  def right_chromatic_for_tonic
    return WITH_FLATS if USE_FLATS.include?(tonic)

    WITH_SHARPS
  end
end

class Scale
  HALF_STEPS_OF = {
    'm' => 1,
    'M' => 2,
    'A' => 3
  }

  def name = "#{tonic.capitalize} #{type}"

  def pitches = build

  private

  attr_reader :tonic, :type, :intervals

  def initialize(tonic, type, intervals = Chromatic::INTERVALS)
    @tonic = tonic
    @type = type
    @intervals = intervals.chars
  end

  def build
    chromatic = Chromatic.new(tonic).call

    by_intervals(chromatic)
  end

  def by_intervals(chromatic)
    wanted_index = tonic_index_in(chromatic)

    intervals.each_with_object([]) do |interval, results|
      results << chromatic.at(wanted_index % chromatic.size)

      wanted_index += HALF_STEPS_OF[interval]
    end
  end

  def tonic_index_in(chromatic) = chromatic.map(&:upcase).index(tonic.upcase)
end
