class Bst
  attr_reader :data, :left, :right

  def initialize(data = nil)
    @data  = data
    @left  = nil
    @right = nil
  end

  def insert(value)
    return delegate_insert_to_children(value) if data.present?

    @data = value
  end

  def each(&)
    return to_enum(__method__) unless block_given?

    left&.each(&)
    yield data
    right&.each(&)
  end

  private

  def delegate_insert_to_children(value)
    child = child_to_delegate(value)

    insert_to(child, value)
  end

  def child_to_delegate(value)
    (value <=> data).positive? ? :right : :left
  end

  def insert_to(child, value)
    instance_variable_set("@#{child}", self.class.new) if public_send(child).nil?

    public_send(child).insert(value)
  end
end
