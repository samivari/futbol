require_relative '../managers/game_teams_manager'
require 'pry'
#Ians Code
class LeagueStatistics
  attr_reader :gtd #gtd stands for games_teams data

  def initialize(game_teams_manager)
    @gtd = game_teams_manager
  end

  def count_of_teams #total number of teams in data
    group_teams.length
  end

  def best_offense #team id with highest average goals per game for all seasons
    team = group_teams.max_by do |game|
      goals = 0
      game[1].each do |team|
        goals += team.goals
      end
      (goals.to_f/ game[1].count)
    end
    team[0]
  end

  def worst_offense #team id with lowest average goals per game for all seasons
    team = group_teams.min_by do |game|
      goals = 0
      game[1].each do |team|
        goals += team.goals
      end
      (goals.to_f / game[1].count)
    end
    team[0]
  end

  def highest_scoring_visitor #team with highest average score per game for all seasons when away
    team = group_teams_away.max_by do |game|
      goals = 0
      game[1].each do |team|
        goals += team.goals
      end
      (goals.to_f / game[1].count)
    end
    team[0]
  end

  def highest_scoring_home_team #team with highest average score per game for all seasons when home
    team = group_teams_home.max_by do |game|
      goals = 0
      game[1].each do |team|
        goals += team.goals
      end
      (goals.to_f / game[1].count)
    end
    team[0]
  end

  def lowest_scoring_visitor #team with lowest average score per game for all seasons when away
    team = group_teams_away.min_by do |game|
      goals = 0
      game[1].each do |team|
        goals += team.goals
      end
      (goals.to_f / game[1].count)
    end
    team[0]
  end

  def lowest_scoring_home_team #team with lowest average score per game for all seasons when home
    team = group_teams_home.min_by do |game|
      goals = 0
      game[1].each do |team|
        goals += team.goals
      end
      (goals.to_f / game[1].count)
    end
    team[0]
  end

  #helper methods

  def group_teams #puts all games for one team in a hash
    @gtd.data.group_by do |game|
      game.team_id
    end
  end

  def group_teams_away #puts all away games for one team in a hash
    @gtd.data.group_by do |game|
      if game.HoA == "away"
        game.team_id
      end
    end
  end

  def group_teams_home #puts all away games for one team in a hash
    @gtd.data.group_by do |game|
      if game.HoA == "home"
        game.team_id
      end
    end
  end
end
