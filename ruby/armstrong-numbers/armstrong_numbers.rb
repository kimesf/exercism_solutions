class ArmstrongNumbers
  def self.include?(integer)
    digits = integer.digits
    length = digits.length

    digits.sum { |digit| digit**length } == integer
  end
end
