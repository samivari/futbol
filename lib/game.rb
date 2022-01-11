class Game
  attr_reader(
    :team_id,
    :season,
    :type,
    :data_time,
    :home_goals,
    :away_goals,
    :away_team_id,
    :home_team_id,
    :venue,
    :venue_link
  )

  def initialize(row)
    @team_id = row[0]
    @season = row[1]
    @type = row[2]
    @data_time = row[3]
    @away_team_id = row[4]
    @home_team_id = row[5]
    @away_goals = row[6]
    @home_goals = row[7]
    @venue = row[8]
    @venue_link = row[9]
  end

  def total_score
    home_goals.to_i + away_goals.to_i
  end

  def home_win?
    home_goals > away_goals
  end

  def visitor_win?
    away_goals > home_goals
  end

  def tie?
    away_goals == home_goals
  end
end
