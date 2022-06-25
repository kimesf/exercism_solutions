class SimpleLinkedList
  def initialize(elements = [])
    @first_el = nil
    push_all(elements)
  end

  def push(obj)
    @first_el = Element.update_or_instantiate(obj, @first_el)
    
    self
  end

  def pop
    return if @first_el.nil?

    poped_el, @first_el = @first_el, @first_el.next
    
    poped_el.unlink!
  end
  
  def to_a = all_elements(:datum)
  
  def reverse!
    old_list  = all_elements
    @first_el = nil
    push_all(old_list)

    self
  end

  private

  def push_all(elements)
    elements.each { push(_1) }
  end
  
  def all_elements(attr = :itself)
    result, current_el = [], @first_el
    
    until current_el.nil?
      result << current_el.public_send(attr)
      current_el = current_el.next
    end
  
    result
  end
end

class Element
  # #next= required for tests
  attr_accessor :next
  attr_reader :datum

  def self.update_or_instantiate(obj, next_el)
    return obj.link!(next_el) if obj.instance_of?(self) 

    new(obj, next_el)
  end

  def initialize(*args)
    @datum, @next = *args
  end

  def link!(element)
    @next = element

    self
  end

  def unlink!
    @next = nil

    self
  end
end
