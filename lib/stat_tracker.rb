require_relative './statistics/game_statistics'
require_relative './statistics/league_statistics'
require_relative './statistics/season_statistics'
require_relative './statistics/team_statistics'
require_relative './managers/game_manager'
require_relative './managers/game_teams_manager'
require_relative './managers/team_manager'

class StatTracker
  attr_reader :season_statistics, :team_statistics

  def initialize(locations)
    game_manager = GameManager.new(locations[:games])
    @game_statistics = GameStatistics.new(game_manager)
    team_manager = TeamManager.new(locations[:teams])
    @team_statistics = TeamStatistics.new(team_manager)
    game_team_manager = GameTeamsManager.new(locations[:game_teams])
    @season_statistics = SeasonStatistics.new(game_team_manager)
    @league_statistics = LeagueStatistics.new(game_team_manager)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # Game Statistics
  def highest_total_score
    @game_statistics.highest_total_score
  end

  def lowest_total_score
    @game_statistics.lowest_total_score
  end

  def percentage_home_wins
    @game_statistics.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_statistics.percentage_visitor_wins
  end

  def percentage_ties
    @game_statistics.percentage_ties
  end

  def count_of_games_by_season
    @game_statistics.count_of_games_by_season
  end

  def average_goals_per_game
    @game_statistics.average_goals_per_game
  end

  def average_goals_by_season
    @game_statistics.average_goals_by_season
  end

  # League Statistics

  def count_of_teams
    @league_statistics.count_of_teams
  end

  def best_offense
    @team_statistics.convert_id_to_team_name(@league_statistics.best_offense)
  end

  def worst_offense
    @team_statistics.convert_id_to_team_name(@league_statistics.worst_offense)
  end

  def highest_scoring_visitor
    @team_statistics.convert_id_to_team_name(@league_statistics.highest_scoring_visitor)
  end

  def highest_scoring_home_team
    @team_statistics.convert_id_to_team_name(@league_statistics.highest_scoring_home_team)
  end

  def lowest_scoring_visitor
    @team_statistics.convert_id_to_team_name(@league_statistics.lowest_scoring_visitor)
  end

  def lowest_scoring_home_team
    @team_statistics.convert_id_to_team_name(@league_statistics.lowest_scoring_home_team)
  end

  # Season Statistics
  def winningest_coach(season_id)
    @season_statistics.winningest_coach(season_id)
  end

  def worst_coach(season_id)
    @season_statistics.worst_coach(season_id)
  end

  def most_accurate_team(season_id)
    @team_statistics.convert_id_to_team_name(@season_statistics.most_accurate_team(season_id))
  end

  def least_accurate_team(season_id)
    @team_statistics.convert_id_to_team_name(@season_statistics.least_accurate_team(season_id))
  end

  def most_tackles(season_id)
    @team_statistics.convert_id_to_team_name(@season_statistics.most_tackles(season_id))
  end

  def fewest_tackles(season_id)
    @team_statistics.convert_id_to_team_name(@season_statistics.fewest_tackles(season_id))
  end

  # Team Statistics
  def team_info(team_id)
    @team_statistics.team_info(team_id)
  end

  def best_season(team_id)
    @game_statistics.best_season(team_id)
  end

  def worst_season(team_id)
    @game_statistics.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @season_statistics.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @season_statistics.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @season_statistics.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @team_statistics.convert_id_to_team_name(@game_statistics.favorite_opponent_team_id(team_id))
  end

  def rival(team_id)
    @team_statistics.convert_id_to_team_name(@game_statistics.rival_team_id(team_id))
  end
end
