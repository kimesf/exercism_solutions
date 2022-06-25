class Hamming
  def self.compute(*dna_strands)
    raise ArgumentError unless dna_strands.chunk(&:size).one?
    
    dna_strands
      .map(&:chars)
      .transpose
      .count { |same_index_letters_ary| !same_index_letters_ary.uniq.one? }
  end
end
