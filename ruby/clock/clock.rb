class Clock
  attr_reader :minutes
  
  def initialize(hour: 0, minute: 0)
    @minutes = (hour * 60) + minute
  end

  def to_s
    [display_hours, display_minutes].map(&method(:format)).join(':')
  end

  def +(clock)
    @minutes += clock.minutes

    self
  end

  def -(clock)
    @minutes -= clock.minutes

    self
  end

  def ==(other_clock)
    to_s == other_clock.to_s
  end

  private

  def format(n)
    ('%02d' % n).to_s
  end

  def display_minutes
    minutes % 60
  end

  def display_hours
    (minutes / 60) % 24
  end
end