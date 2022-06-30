class Matrix
  attr_reader :rows, :columns, :saddle_points

  private

  def initialize(string_matrix)
    @rows, @columns = parse(string_matrix)
    @saddle_points  = find_saddle_points
  end

  def find_saddle_points
    for_every_value.with_object([]) do |(row, column, value), result|
      next unless larger_in_row?(row, value) && smaller_in_column?(column, value)

      result.push [row, column]
    end
  end

  def parse(string_matrix)
    head, *tail = *string_matrix.lines.map { |line| line.split(' ').map(&:to_i) }

    rows    = [head, *tail]
    columns = head.zip(*tail)

    [rows, columns]
  end

  def for_every_value
    return to_enum(:for_every_value) unless block_given?

    rows.each_with_index do |row, row_index|
      row.each_with_index do |value, column_index|
        yield(row_index, column_index, value)
      end
    end
  end

  def smaller_in_column?(index, value)= columns[index].min == value

  def larger_in_row?(index, value)= rows[index].max == value
end
