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

  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # Game Statistics

  # League Statistics

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
