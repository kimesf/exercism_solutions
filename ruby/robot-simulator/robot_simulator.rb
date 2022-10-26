class Simulator
  INSTRUCTIONS_CODEX = {
    'A' => :advance,
    'R' => :turn_right,
    'L' => :turn_left
  }

  private_constant :INSTRUCTIONS_CODEX

  def instructions(coded_intructions) = decode(coded_intructions)

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, coded_intructions)
    instructions(coded_intructions).each do |instruction|
      robot.public_send(instruction)
    end
  end

  private

  def initialize; end

  def decode(code)
    code.each_char.map { |char| INSTRUCTIONS_CODEX[char] }
  end
end

class Robot
  ORIENTATIONS_CONFIG = {
    west:  { axis: :@x_position, direction: -1 },
    north: { axis: :@y_position, direction: +1 },
    east:  { axis: :@x_position, direction: +1 },
    south: { axis: :@y_position, direction: -1 }
  }.freeze

  ORIENTATIONS = ORIENTATIONS_CONFIG.keys

  ORIENTATIONS_TURN = {
    left:  -1,
    right: +1
  }

  private_constant :ORIENTATIONS_CONFIG, :ORIENTATIONS, :ORIENTATIONS_TURN

  attr_accessor :bearing, :x_position, :y_position

  def orient(orientation)
    validate_orientation!(orientation)

    self.bearing = orientation
  end

  def at(*positions)
    self.x_position, self.y_position = positions
  end

  def coordinates = [x_position, y_position]
  def turn_left   = turn(:left)
  def turn_right  = turn(:right)
  def advance     = move_foward(**ORIENTATIONS_CONFIG[bearing])

  private

  def initialize; end

  def move_foward(axis:, direction:)
    current_position = instance_variable_get(axis)
    new_position     = current_position + direction

    instance_variable_set(axis, new_position)
  end

  def turn(direction)
    index_change  = ORIENTATIONS_TURN[direction]
    current_index = ORIENTATIONS.find_index(bearing)
    new_index     = (current_index + index_change) % ORIENTATIONS.size
    orientation   = ORIENTATIONS[new_index]

    orient(orientation)
  end

  def validate_orientation!(orientation)
    raise ArgumentError unless ORIENTATIONS.include?(orientation)
  end
end
