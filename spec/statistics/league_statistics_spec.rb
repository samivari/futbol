require './spec/spec_helper'
require './lib/statistics/league_statistics'
require 'RSpec'
require 'ostruct'
require 'pry'

RSpec.describe LeagueStatistics do
  before(:each) do
    mock_game_team_1 = OpenStruct.new({ team_id: "3", HoA: "away", goals: 3})
    mock_game_team_2 = OpenStruct.new({ team_id: "6", HoA: "home", goals: 5})
    mock_game_team_3 = OpenStruct.new({ team_id: "3", HoA: "home", goals: 9})
    mock_game_team_4 = OpenStruct.new({ team_id: "6", HoA: "away", goals: 5})
    mock_game_team_5 = OpenStruct.new({ team_id: "2", HoA: "away", goals: 2})
    mock_game_team_6 = OpenStruct.new({ team_id: "2", HoA: "home", goals: 1})
    mock_game_team_manager = OpenStruct.new({ data: [mock_game_team_1, mock_game_team_2, mock_game_team_3, mock_game_team_4, mock_game_team_5, mock_game_team_6]})
    @league_statistics = LeagueStatistics.new(mock_game_team_manager)
  end

  describe "counts teams" do
    it "shows correct number of teams" do
      actual = @league_statistics.count_of_teams
      expected = 3
      expect(actual).to eq(expected)
    end
  end

  describe "find offense" do
    it "puts one teams games into an array" do
      actual = @league_statistics.group_teams
      expect(actual).to be_a(Hash)
    end

    it "finds highest average goals overall" do
      actual = @league_statistics.best_offense
      expected = "3"
      expect(actual).to eq(expected)
    end

    it "finds lowest average goals overall" do
      actual = @league_statistics.worst_offense
      expected = "2"
      expect(actual).to eq(expected)
    end
  end

  describe "finds HoA avaerages" do
    it "finds highest average goals per game while away" do
      actual = @league_statistics.highest_scoring_visitor
      expected = "6"
      expect(actual).to eq(expected)
    end

    it "finds highest average goals per game while home" do
      actual = @league_statistics.highest_scoring_home_team
      expected = "6"
      expect(actual).to eq(expected)
    end
  end
end
