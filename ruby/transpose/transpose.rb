class Transpose
  def self.transpose(input)
    lines   = input.split("\n").map(&:chars)
    largest = lines.map(&:length).max || 0
    padding = [nil] * largest

    padded_lines = lines.map { |line| (line + padding).take(largest) }
    transposed   = padded_lines.transpose
    unpadded     = transposed.map { |line| line.reverse.drop_while(&:nil?).reverse }
    final        = unpadded.map { |line| line.map { |char| char.nil? ? ' ' : char } }

    final.map(&:join).join("\n")
  end
end
