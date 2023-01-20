require 'matrix'
require 'forwardable'

class Board
  extend Forwardable

  def_delegators :rules, :bomb?, :free_space?

  def self.transform(...) = new(...).transform

  def initialize(rows)
    @board          = Matrix[*rows.map { |row| row.each_char.to_a }]
    @rules          = MineSweeperRules.new(board)
    @row_count      = board.row_count
    @col_count      = board.column_count
    @is_transformed = false

    rules.validate!
  rescue ExceptionForMatrix::ErrDimensionMismatch => _e
    raise ArgumentError
  end

  def formatted_board = board.to_a.map(&:join)

  def transform
    populatate_with_hints! unless transformed?

    formatted_board
  end

  private

  attr_reader :board, :col_count, :row_count, :rules, :is_transformed

  def populatate_with_hints!
    for_every_board_free_space do |coordenates|
      bomb_count = bomb_count_around(*coordenates)

      board[*coordenates] = bomb_count if bomb_count.positive?
    end

    transformed!
  end

  def bomb_count_around(row, col)
    coordenates_around(row, col).count do |coordenates|
      bomb? board[*coordenates]
    end
  end

  def coordenates_around(row, col)
    rows_around = [*row - 1..row + 1]
    cols_around = [*col - 1..col + 1]

    rows_around
      .product(cols_around)
      .select { |coordenates| valid_coordenate_around_origin?(*coordenates, row, col) }
  end

  def valid_coordenate_around_origin?(row, col, origin_row, origin_col)
    is_not_self          = row != origin_row || col != origin_col
    is_after_left_wall   = [row, col].all?(&:positive?)
    is_before_right_wall = row <= row_count && col <= col_count

    is_not_self &&
      is_after_left_wall &&
      is_before_right_wall
  end

  def transformed!
    @is_transformed = true
  end

  def transformed? = is_transformed

  def for_every_board_free_space
    board.each_with_index do |element, *coordenates|
      yield(coordenates) if free_space?(element)
    end
  end
end

class MineSweeperRules
  BOMB       = '*'.freeze
  CEIL_FLOOR = '-'.freeze
  CORNER     = '+'.freeze
  FREE_SPACE = ' '.freeze
  SIDE_WALL  = '|'.freeze

  private_constant :BOMB, :CEIL_FLOOR, :CORNER, :FREE_SPACE, :SIDE_WALL

  def initialize(board)
    @board = board
  end

  def validate!
    validate_elements!
    validade_structure!
  end

  def bomb?(element) = BOMB == element

  def free_space?(element) = FREE_SPACE == element

  private

  attr_reader :board

  def array_board = board.to_a

  def validate_elements!
    board.each do |element|
      next if [SIDE_WALL, CEIL_FLOOR, CORNER, BOMB, FREE_SPACE].include?(element)

      raise ArgumentError
    end
  end

  def validade_structure!
    return if top_border_valid? && bot_border_valid? && side_walls_valid?

    raise ArgumentError
  end

  def top_border_valid? = border_valid?(array_board.first)

  def bot_border_valid? = border_valid?(array_board.last)

  def side_walls_valid?
    middle_rows = array_board[1...-1]

    middle_rows.all? do |row|
      [row.first, row.last].all? { |element| SIDE_WALL == element }
    end
  end

  def border_valid?(row)
    row.all? { |element| [CORNER, CEIL_FLOOR].include?(element) }
  end
end
