class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze
  DIVISION_BY_ZERO_ERROR = "Division by zero is not allowed."

  class UnsupportedOperation < StandardError; end
  
  def self.calculate(*args)
    new(*args).calculate
  rescue ZeroDivisionError
    DIVISION_BY_ZERO_ERROR
  end

  def initialize(*args)
    @first_operand, @second_operand, @operation = args
    @answer = nil
  end
  
  def calculate
    validate_arguments
    find_answer!
    
    formatted_result
  end

  private 

  def validate_arguments
    raise UnsupportedOperation unless ALLOWED_OPERATIONS.include? @operation
    raise ArgumentError unless [@first_operand, @second_operand].all? Numeric 
  end

  def find_answer!
    @answer = @first_operand.public_send(@operation, @second_operand)
  end
  
  def formatted_result
    [@first_operand, @operation, @second_operand, "=", @answer].join(" ")
  end
end
