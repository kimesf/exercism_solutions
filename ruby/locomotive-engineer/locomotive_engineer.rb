class LocomotiveEngineer
  def self.generate_list_of_wagons(*wagon_ids) = wagon_ids

  def self.fix_list_of_wagons((first, second, thirdy, *tail), missing_wagons)
    [thirdy, *missing_wagons, *tail, first, second]
  end

  def self.add_missing_stops(route, **stops)
    { **route, stops: stops.values }
  end

  def self.extend_route_information(route, more_route_information)
    { **route, **more_route_information }
  end
end
