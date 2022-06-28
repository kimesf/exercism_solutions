class FlattenArray
  def self.flatten(obj)
    # ary.flatten.compact

    return obj unless obj.is_a?(Array)
    return if obj.empty?

    head, *tail = obj

    [*flatten(head), *flatten(tail)]
  end
end
