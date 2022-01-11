require_relative '../managers/team_manager.rb'
require 'pry'
class TeamStatistics
  attr_reader :manager

  def initialize(team_manager)
    @team_manager = team_manager
  end

  def team_info(team_id)
    hash = {}
    @team_manager.data.select do |team|
      if team.team_id == team_id
        hash["team_id"] = team.team_id
        hash["franchise_id"] = team.franchise_id
        hash["team_name"] = team.team_name
        hash["abbreviation"] = team.abbreviation
        hash["link"] = team.link
      end
    end
    return hash
  end

  def convert_id_to_team_name(team_id)
    matching_team = @team_manager.data.find{ |team| team.team_id == team_id }
    return matching_team.team_name
  end
end
