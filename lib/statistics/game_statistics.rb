require_relative '../managers/game_teams_manager'
class GameStatistics
  attr_reader :games

  def initialize(game_manager)
    @games = game_manager
  end

  def highest_total_score
    game_with_highest_total_score = games.data.max_by { |game| game.total_score }

    game_with_highest_total_score.total_score
  end

  def lowest_total_score
    game_with_lowest_total_score = games.data.min_by { |game| game.total_score }

    game_with_lowest_total_score.total_score
  end

  def percentage_home_wins
    home_wins = games.data.find_all { |game| game.home_win? }.count
    game_count = games.data.count
    (home_wins.to_f / game_count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = games.data.find_all { |game| game.visitor_win? }.count
    game_count = games.data.count
    (visitor_wins.to_f / game_count.to_f).round(2)
  end

  def percentage_ties
    tie_count = games.data.find_all { |game| game.tie? }.count
    game_count = games.data.count
    (tie_count.to_f / game_count.to_f).round(2)
  end

  def count_of_games_by_season
    results = Hash.new(0)
    seasons = games.data.map { |game| game.season }
    seasons.group_by { |season| results[season] += 1 }

    results
  end

  def average_goals_per_game
    ((games.data.sum { |game| game.total_score.to_f }) / games.data.count).round(2)
  end

  def average_goals_by_season
    result = Hash.new(0)
    data_by_season.each do |season|
      goal_array = season[1].map do |game|
        game.total_score
      end
      result[season[0]] = (goal_array.reduce(:+) / goal_array.size.to_f).round(2)
    end
    result
  end
  # Aedan's methods (Aedan is super cool)

  def data_by_season
    @games.data.group_by { |game| game.season}
  end

  def best_season(team_id)
    selected = data_by_season.max_by do |season|
      game_count = season[1].find_all do |game|
        game.away_team_id == team_id || game.home_team_id == team_id
      end.count
      home_wins = season[1].find_all do |game|
        (team_id == game.home_team_id) && game.home_win?
      end.count
      away_wins = season[1].find_all do |game|
        (team_id == game.away_team_id) && game.visitor_win?
      end.count
      ((home_wins.to_f + away_wins.to_f) / game_count.to_f).round(10)
    end
    selected.first
  end

  def worst_season(team_id)
    selected = data_by_season.min_by do |season|
      game_count = season[1].find_all do |game|
        game.away_team_id == team_id || game.home_team_id == team_id
      end.count
      home_wins = season[1].find_all do |game|
        (team_id == game.home_team_id) && game.home_win?
      end.count
      away_wins = season[1].find_all do |game|
        (team_id == game.away_team_id) && game.visitor_win?
      end.count
      ((home_wins.to_f + away_wins.to_f) / game_count.to_f).round(10)
    end
    selected.first
  end

  def group_home_team(team_id)
    hash = @games.data.group_by { |game| game.home_team_id if game.home_team_id == team_id}
    hash.delete(nil)
    hash
  end

  def group_away_team(team_id)
    hash = @games.data.group_by { |game| game.away_team_id if game.away_team_id == team_id}
    hash.delete(nil)
    hash
  end

  def group_away_opponents(team_id)
    hash = group_home_team(team_id).flat_map { |team| team[1].group_by { |game| game.away_team_id}}
    hash.first
  end

  def group_home_opponents(team_id)
    hash = group_away_team(team_id).flat_map { |team| team[1].group_by { |game| game.home_team_id}}
    hash.first
  end

  def grouped_opponents(team_id)
    merged = group_home_opponents(team_id).merge(group_away_opponents(team_id)) {|key, old, new| Array(old).push(new)}
    merged.collect { |team| team[1].flatten! }
    merged
  end

  def favorite_opponent_team_id(team_id)
    grouped_opponents(team_id).min_by do |team|
      games = team[1].count
      wins = 0
      team[1].each do |game|
        if team_id == game.home_team_id && game.visitor_win? then wins += 1
        elsif team_id == game.away_team_id && game.home_win? then wins += 1
        end
      end
      percent = (wins.to_f / games) * 100
    end.first
  end
  
  def rival_team_id(team_id)
    grouped_opponents(team_id).max_by do |team|
      games = team[1].count
      wins = 0
      team[1].each do |game|
        if team_id == game.home_team_id && game.visitor_win? then wins += 1
        elsif team_id == game.away_team_id && game.home_win? then wins += 1
        end
      end
      percent = (wins.to_f / games) * 100
    end.first
  end
end
