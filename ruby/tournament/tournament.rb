class Team
  POINTS = {
    win: 3,
    draw: 1
  }.freeze

  private

  attr_reader :name, :wins, :losses, :draws

  def initialize(name)
    @name = name
    @wins = 0
    @losses = 0
    @draws = 0
  end

  def matches_played = wins + losses + draws

  def points = wins * POINTS[:win] + draws * POINTS[:draw]

  public

  def win!
    @wins += 1
  end

  def loss!
    @losses += 1
  end

  def draw!
    @draws += 1
  end

  def info
    { name:, matches_played:, wins:, draws:, losses:, points: }
  end
end

class Display
  TEMPLATE = "%<name>-30s | %<matches_played>2s | %<wins>2s | %<draws>2s | %<losses>2s | %<points>2s\n".freeze
  HEADER = { name: 'Team', matches_played: 'MP', wins: 'W', draws: 'D', losses: 'L', points: 'P' }.freeze

  def self.render(teams_info) = new(teams_info).table

  private

  def initialize(teams_info)
    @table = render(teams_info)
  end

  def render(teams_info)
    teams_info.inject(header) do |memo, info|
      memo += new_line info
      memo
    end
  end

  def header = new_line(HEADER)

  def new_line(info) = format(TEMPLATE, info)

  public

  attr_reader :table
end

class Tournament
  WIN  = 'win'.freeze
  LOSS = 'loss'.freeze
  DRAW = 'draw'.freeze

  def self.tally(matches)= new(matches).tally

  private

  attr_reader :teams, :matches

  def initialize(matches)
    @teams = Hash.new { |hash, key| hash[key] = Team.new(key) }
    @matches = matches.strip.lines.map { _1.strip.split(';') }

    process_scores
  end

  def process_scores
    matches.each do |name1, name2, result|
      match_teams = [name1, name2].map { teams[_1] }

      case result
      when WIN  then score_winner_loser(*match_teams)
      when LOSS then score_winner_loser(*match_teams.reverse)
      when DRAW then score_draw(match_teams)
      end
    end
  end

  def score_draw(teams)
    teams.each(&:draw!)
  end

  def score_winner_loser(winner, loser)
    winner.win! && loser.loss!
  end

  def teams_info_sorted_by_points_and_name
    teams
      .values
      .map(&:info)
      .sort_by { |team| [-team[:points], team[:name]] }
  end

  public

  def tally
    Display.render(teams_info_sorted_by_points_and_name)
  end
end
