require_relative '../managers/game_teams_manager'
require 'pry'
#Ians Code
class LeagueStatistics
  attr_reader :gtd #gtd stands for games_teams data

  def initialize(game_teams_manager)
    @gtd = game_teams_manager
  end

  # def team_id_array #puts every team id into an array
  #   arr = []
  #   team_ids = @gtd.data.each do |game|
  #     if !arr.include? game.team_id
  #       arr << game.team_id
  #     end
  #   end
  # end

  def count_of_teams #total number of teams in data
    group_teams.length
  end

  def group_teams
    @gtd.data.group_by do |game|
      game.team_id
    end
  end

  def best_offense #goals / number of games played
    team = group_teams.max_by do |game|
      goals = 0
      game[1].each do |team|
        goals += team.goals
      end
      (goals / game[1].count)
    end
    team[0]
  end

  def worst_offense #team with lowext average goals per game for all seasons
    team = group_teams.min_by do |game|
      goals = 0
      game[1].each do |team|
        goals += team.goals
      end
      (goals / game[1].count)
    end
    team[0]
  end


  def highest_scoring_visitor #team with highest average score per game for all seasons when away
    arr = []
    @gtd.data.each do |game|
      if game.HoA == away
        arr << game.team_id
      end
    end
  end


  def highest_scoring_home_team #team with highest average score per game for all seasons when home
    #highest number in average_goals_HoA method for home
  end

  def lowest_scoring_visitor #team with lowest average score per game for all seasons when away
    #lowest number in average_goals_HoA method for away
  end

  def lowest_scoring_home_team #team with lowest average score per game for all seasons when home
    #lowest number in average_goals_HoA method for home
  end
end
