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
    (home_wins.to_f / game_count.to_f).round(5)
  end

  def percentage_visitor_wins
    visitor_wins = games.data.find_all { |game| game.visitor_win? }.count
    game_count = games.data.count
    (visitor_wins.to_f / game_count.to_f).round(5)
  end

  def percentage_ties
    tie_count = games.data.find_all { |game| game.tie? }.count
    game_count = games.data.count
    (tie_count.to_f / game_count.to_f).round(5)
  end

  def count_of_games_by_season
    results = Hash.new(0)
    seasons = games.data.map { |game| game.season }
    seasons.group_by { |season| results[season] += 1 }

    results
  end

  def average_goals_per_game
    ((games.data.sum { |game| game.total_score.to_f }) / games.data.count).round(5)
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
    @games.data.group_by do |game|
      game.season
    end
  end

  def best_season(team_id)
    selected = data_by_season.max_by do |season|
      home_wins = season[1].find_all do |game|
        (team_id == game.home_team_id) && game.home_win?
      end.count
      away_wins = season[1].find_all do |game|
        (team_id == game.away_team_id) && game.visitor_win?
      end.count
      wins = 0
      game_count = season[1].count
      wins += (home_wins + away_wins)
      ((home_wins.to_f + away_wins.to_f) / game_count).round(5) * 100
    end
    selected.first
  end

  def worst_season(team_id)
    selected = data_by_season.min_by do |season|
      home_wins = season[1].find_all do |game|
        (team_id == game.home_team_id) && game.home_win?
      end.count
      away_wins = season[1].find_all do |game|
        (team_id == game.away_team_id) && game.visitor_win?
      end.count
      wins = 0
      game_count = season[1].count
      wins += (home_wins + away_wins)
      ((home_wins.to_f + away_wins.to_f) / game_count).round(5) * 100
    end
    selected.first
  end

  # returns hash with team_id = home_team keys and game values with mixed teams
  def group_home_team(team_id)
    hash = @games.data.group_by do |game|
      game.home_team_id if game.home_team_id == team_id
    end
    hash.delete(nil)
    hash
  end

  # returns hash with team_id = away_team keys and game values with mixed teams
  def group_away_team(team_id)
    hash = @games.data.group_by do |game|
      game.away_team_id if game.away_team_id == team_id
    end
    hash.delete(nil)
    hash
  end

  # returns [{hash}] with opponent = away_team keys and game object values with team
  def group_away_opponents(team_id)
    hash = group_home_team(team_id).flat_map do |team|
      team[1].group_by do |game|
        game.away_team_id
      end
    end
    hash.first
  end

  # returns [{hash}] with opponent = home_team keys and game object values with desired team
  def group_home_opponents(team_id)
    hash = group_away_team(team_id).flat_map do |team|
      team[1].group_by do |game|
        game.home_team_id
      end
    end
    hash.first
  end

  def grouped_opponents(team_id)
    a = group_home_opponents(team_id).merge(group_away_opponents(team_id)) { |_key, old, new| Array(old).push(new) }
    done = a.collect do |team|
      team[1].flatten!
    end
    a
  end

  def favorite_opponent_team_id(team_id)
    team = grouped_opponents(team_id).min_by do |team|
      games = team[1].count
      wins = 0
      team[1].each do |game|
        if team_id == game.home_team_id && game.visitor_win? then wins += 1
        elsif team_id == game.away_team_id && game.home_win? then wins += 1
        end
      end
      percent = (wins.to_f / games) * 100
    end
    team.first
  end

  def rival_team_id(team_id)
    team = grouped_opponents(team_id).max_by do |team|
      games = team[1].count
      wins = 0
      team[1].each do |game|
        if team_id == game.home_team_id && game.visitor_win? then wins += 1
        elsif team_id == game.away_team_id && game.home_win? then wins += 1
        end
      end
      percent = (wins.to_f / games) * 100
    end
    team.first
  end
end
