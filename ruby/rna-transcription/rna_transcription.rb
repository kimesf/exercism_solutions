class Complement
  DNA_NUCLEOTIDES = 'GCTA'.freeze
  RNA_NUCLEOTIDES = 'CGAU'.freeze

  def self.of_dna(dna_strand)
    dna_strand.tr(DNA_NUCLEOTIDES, RNA_NUCLEOTIDES)
  end
end
