class Nucleotide
  DISALLOWED = /[^ATCG]/
  DEFAULT_HISTOGRAM = { 'A' => 0, 'T' => 0, 'C' => 0, 'G' => 0 }.freeze

  private_constant :DISALLOWED, :DEFAULT_HISTOGRAM

  def self.from_dna(strain)= new(strain)

  private

  def initialize(strain)
    validate(strain)

    @histogram = count_all(strain)
  end

  def count_all(strain)
    strain.chars.each_with_object(DEFAULT_HISTOGRAM.dup) do |letter, histogram|
      histogram[letter] += 1
    end
  end

  def validate(strain)
    raise ArgumentError unless strain.scan(DISALLOWED).empty?
  end

  public

  attr_reader :histogram

  def count(dna_letter)= histogram[dna_letter]
end
