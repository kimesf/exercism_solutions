class Grains
  SQUARES_ON_CHESSBOARD = 64

  def self.square(square_number)
    raise ArgumentError unless (1..SQUARES_ON_CHESSBOARD).include?(square_number)

    square_number_starting_from_second_square = square_number - 1

    2**square_number_starting_from_second_square
  end

  def self.total
    (2..SQUARES_ON_CHESSBOARD).reduce(1) { |grains, square_number| grains + square(square_number) }
  end
end
