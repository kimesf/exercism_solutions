class Matrix
  attr_reader :rows, :columns 
  
  def initialize(text)
    @rows = text.lines.map { _1.split.map(&:to_i) }
    @columns = rows.transpose
  end
end

