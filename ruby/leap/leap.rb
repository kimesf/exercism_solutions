class Year
  def self.leap?(year)
    year.modulo(4).zero? &&
      year.modulo(100).positive? || year.modulo(400).zero?
  end
end
