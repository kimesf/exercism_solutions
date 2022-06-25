class Gigasecond
  BILLION_SECONDS = 10**9

  def self.from(date)
    date + BILLION_SECONDS
  end
end
