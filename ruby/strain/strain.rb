class Array
  def keep
    return to_enum(__method__) unless block_given?

    result = []

    each do |item|
      result << item if yield(item)
    end

    result
  end

  def discard
    return to_enum(__method__) unless block_given?

    result = []

    each do |item|
      result << item unless yield(item)
    end

    result
  end
end
