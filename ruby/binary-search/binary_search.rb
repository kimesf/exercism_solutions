class BinarySearch
  Element = Struct.new(:value, :index)

  private_constant :Element

  def search_for(wanted, botton_limit: -1, top_limit: data_with_index.count)
    half_index      = half(botton_limit, top_limit)
    current_element = Element.new(*data_with_index[half_index])

    case compare(wanted, current_element.value)
    when :match   then return current_element.index
    when :smaller then top_limit    = half_index
    when :bigger  then botton_limit = half_index
    end

    return if had_one_element_left?(botton_limit, top_limit)

    search_for(wanted, botton_limit:, top_limit:)
  end

  private

  attr_reader :data_with_index

  def initialize(data)
    @data_with_index = data.each_with_index.to_a
  end

  def half(lower, higher)
    diff = higher - lower

    lower + diff.div(2)
  end

  def compare(num1, num2)
    case num1 <=> num2
    when -1 then :smaller
    when  0 then :match
    when  1 then :bigger
    end
  end

  def had_one_element_left?(botton_limit, top_limit)
    diff = top_limit - botton_limit

    diff == 1
  end
end
