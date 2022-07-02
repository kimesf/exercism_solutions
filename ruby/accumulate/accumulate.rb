class Array
  def accumulate
    return to_enum(__method__) unless block_given?

    result = []

    each do |item|
      result << yield(item)
    end

    result
  end
end

