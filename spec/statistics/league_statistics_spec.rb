require './spec/spec_helper'
require './lib/statistics/league_statistics'
require 'RSpec'
require 'ostruct'

RSpec.describe LeagueStatistics do
  before(:each) do
    mock_game_team_1 = OpenStruct.new({ team_id: "3", goals: 3})
    mock_game_team_2 = OpenStruct.new({ team_id: "6", goals: 4})
    mock_game_team_3 = OpenStruct.new({ team_id: "3", goals: 5})
    mock_game_team_4 = OpenStruct.new({ team_id: "6", goals: 5})
    mock_game_team_4 = OpenStruct.new({ team_id: "5", goals: 2})
    mock_game_team_manager = OpenStruct.new({ data: [mock_game_team_1, mock_game_team_2, mock_game_team_3] })
    @league_statistics = LeagueStatistics.new(mock_game_team_manager)
  end

  describe "counts teams" do
    it "puts the teams into an array" do
      expect(@league_statistics.team_id_array).to include(OpenStruct)
      expect(@league_statistics.team_id_array.length).to eq(3)
    end

    it "shows correct number of teams" do
      actual = @league_statistics.count_of_teams
      expected = 3
      expect(actual).to eq(expected)
    end
  end

  describe "find best offense" do
    xit "returns average goals for all seasons" do
      actual = @league_statistics.average_goals_overall
      expected = 4
      expect(actual).to eq(expected)
    end

    xit "finds highest average goals overall" do
      actual = @league_statistics.best_offense
      expected = "6"
      expect(actual).to eq(expected)
    end

    xit "puts all team ids into an array" do
      actual = @league_statistics.teams_into_array()
      expect()
    end
  end

end
