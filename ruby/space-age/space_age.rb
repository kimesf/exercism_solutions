class SpaceAge
  SOLAR_SYSTEM_PLANETS_ORBIT_RATIOS = {
    mercury: 0.2408467,
    venus: 0.61519726,
    earth: 1.0,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132
  }.freeze

  SECONDS_IN_EARTH_YEAR = 31_557_600

  private_constant :SECONDS_IN_EARTH_YEAR, :SOLAR_SYSTEM_PLANETS_ORBIT_RATIOS

  private

  attr_reader :age_in_seconds

  def initialize(age_in_seconds)
    @age_in_seconds = age_in_seconds
  end

  def seconds_in_a_year_on(planet)
    SECONDS_IN_EARTH_YEAR * SOLAR_SYSTEM_PLANETS_ORBIT_RATIOS[planet]
  end

  public

  SOLAR_SYSTEM_PLANETS_ORBIT_RATIOS.each do |planet, _ratio|
    define_method :"on_#{planet}" do
      age_in_seconds / seconds_in_a_year_on(planet)
    end
  end
end
