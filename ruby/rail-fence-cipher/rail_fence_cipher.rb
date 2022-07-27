class RailFenceCipher
  ZigZag = Struct.new(:spread, :upto) do
    def call
      one_cycle_zig_zag
        .cycle
        .first(upto)
    end

    private

    def one_cycle_zig_zag
      downwards  = [*0...spread]
      upwards    = downwards[1...-1].reverse

      downwards + upwards
    end
  end

  private_constant :ZigZag

  def self.encode(message, rails_amount)
    new(subject: message, rails_amount:).encode
  end

  def self.decode(cipher, rails_amount)
    new(subject: cipher, rails_amount:).decode
  end

  def encode = separate_in_rows(zig_zag_indexes).join

  def decode = unzig_zag_subject.join

  private

  attr_reader :subject, :zig_zag_indexes

  def initialize(subject:, rails_amount:)
    @zig_zag_indexes = ZigZag.new(rails_amount, subject.size).call
    @subject = subject
  end

  def unzig_zag_subject
    rows = separate_in_rows(zig_zag_indexes.sort)

    zig_zag_indexes.each_with_object([]) do |index, result|
      result << rows[index].shift
    end
  end

  def separate_in_rows(row_index_path)
    zipped = subject.chars.zip(row_index_path)

    zipped.each_with_object([]) do |(char, row_index), result|
      (result[row_index] ||= []) << char
    end
  end
end
