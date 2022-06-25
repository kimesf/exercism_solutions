class BoutiqueInventory
  CHEAP_ITEMS_PRICE_RANGE = (-Float::INFINITY...30).freeze
  
  def initialize(items)
    @items = items
  end

  def item_names
    @items.map{ _1[:name] }.sort
  end

  def cheap
    @items.filter{ CHEAP_ITEMS_PRICE_RANGE.include? _1[:price] }
  end

  def out_of_stock
    @items.filter do |item |
      quantities = item[:quantity_by_size].values
      
      quantities.empty? || quantities.all?(&:zero?)
    end
  end

  def stock_for_item(name)
    @items .find{ _1[:name] == name }[:quantity_by_size]
  end

  def total_stock
    @items.sum { _1[:quantity_by_size].values.sum }
  end

  private
  attr_reader :items
end
