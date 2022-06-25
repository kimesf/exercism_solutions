class BirdCount
  DEFAULT_COUNT   = [0, 2, 5, 3, 7, 8, 4].freeze
  TOO_MANY_BIRDS  = 5
  YESTERDAY_INDEX = 5
  
  def self.last_week = DEFAULT_COUNT

  def initialize(last_week_birds_per_day)
    @last_week_birds_per_day = last_week_birds_per_day
  end

  def yesterday
    @last_week_birds_per_day[YESTERDAY_INDEX]
  end

  def total
    @last_week_birds_per_day.sum
  end

  def busy_days
    @last_week_birds_per_day.filter{ _1 >= TOO_MANY_BIRDS }.count
  end

  def day_without_birds?
    @last_week_birds_per_day.any?(&:zero?)
  end
end
