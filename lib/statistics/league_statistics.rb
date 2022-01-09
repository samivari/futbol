require_relative '../managers/game_teams_manager'
require 'pry'
#Ians Code
class LeagueStatistics
  attr_reader :gtd #gtd stands for games_teams data

  def initialize(game_teams_manager)
    @gtd = game_teams_manager
  end

  def team_id_array #puts every team id into an array
    arr = []
    team_ids = gtd.data.each do |game|
      if !arr.include? game.team_id
        arr << game.team_id
      end
    end
  end

  def count_of_teams #total number of teams in data
    team_id_array.length
  end


  def best_offense #team with highest average goals per game for all seasons
    #highest number in average_goals_overall method
    #team_with_best_offense = gtd.data.max_by { |team| team.find_team_offense(team)}
    #@team_statistics.convert_id_to_team_name()

  end

  def average_goals_overall_per_game
    # goals / number of games played
    a = 0
    b = 0
    @gtd.data.each do |game|
      # require 'pry'; binding.pry
      a += game.goals
      b += 1
    end
    return a / b
  end

  def worst_offense #team with lowext average goals per game for all seasons
    #lowest number in average_goals_overall method
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
