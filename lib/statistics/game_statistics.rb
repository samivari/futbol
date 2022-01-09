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
    (home_wins.to_f / game_count.to_f).round(5) * 100
  end

  def percentage_visitor_wins
    visitor_wins = games.data.find_all { |game| game.visitor_win? }.count
    game_count = games.data.count
    (visitor_wins.to_f / game_count.to_f).round(5) * 100
  end

  def percentage_ties
    tie_count = games.data.find_all { |game| game.tie? }.count
    game_count = games.data.count
    (tie_count.to_f / game_count.to_f).round(5) * 100
  end

  def count_of_games_by_season
    results = Hash.new(0)
    seasons = games.data.map { |game| game.season }
    seasons.group_by { |season| results[season] += 1 }

    results
  end

  def average_goals_per_game
    (games.data.sum { |game| game.total_score }) / games.data.count
  end

  # Aedan's methods

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

  def favorite_opponent_team_id(team_id)
    o_win_counter = 0
    o_loss_counter = 0
    games = 0
    chosen = @games.data.min_by do |game|
      opponent_win = (team_id == game.home_team_id) && game.visitor_win?
      if opponent_win == true then o_win_counter += 1 and games += 1
      end
      opponent_lose = (team_id == game.away_team_id) && game.visitor_win?
      if opponent_lose == true then o_loss_counter +=1 and games += 1
      end
      (o_win_counter.to_f/games) * 100
    end
    return chosen.home_team_id if chosen.home_team_id != team_id
    return chosen.away_team_if if chosen.away_team_if != team_id
  end
end
