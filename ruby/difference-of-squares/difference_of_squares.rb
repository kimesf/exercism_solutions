class Squares
  private

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def upto_number()= 1.upto(number)

  public

  def square_of_sum()= upto_number.sum**2

  def sum_of_squares()= upto_number.reduce(0) { |memo, n| memo + n**2 }

  def difference()= square_of_sum - sum_of_squares
end
