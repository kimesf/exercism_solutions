class CollatzConjecture
  def self.steps(start_number)
    raise ArgumentError unless start_number.positive?

    steps = 0
    current = start_number

    until current == 1
      steps += 1
      next current /= 2 if current.even?

      current *= 3
      current += 1
    end

    steps
  end
end
