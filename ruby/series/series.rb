class Series
  def initialize(series)
    @series = series
  end

  def slices(n)
    raise ArgumentError if n > @series.size
    
    @series.chars.each_cons(n).map(&:join)
  end
end
