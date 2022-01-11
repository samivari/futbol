require './spec/spec_helper'
require './lib/statistics/league_statistics'
require 'RSpec'
require 'ostruct'
require 'pry'

RSpec.describe LeagueStatistics do
  before(:each) do
    m1 = OpenStruct.new({ team_id: "3", HoA: "away", goals: 3})
    m2 = OpenStruct.new({ team_id: "6", HoA: "home", goals: 5})
    m3 = OpenStruct.new({ team_id: "3", HoA: "away", goals: 9})
    m4 = OpenStruct.new({ team_id: "6", HoA: "home", goals: 5})
    m5 = OpenStruct.new({ team_id: "6", HoA: "away", goals: 2})
    m6 = OpenStruct.new({ team_id: "3", HoA: "home", goals: 4})
    m7 = OpenStruct.new({ team_id: "5", HoA: "away", goals: 3})
    m8 = OpenStruct.new({ team_id: "5", HoA: "home", goals: 7})
    m9 = OpenStruct.new({ team_id: "5", HoA: "away", goals: 6})
    m10 = OpenStruct.new({ team_id: "5", HoA: "home", goals: 2})
    mock_game_team_manager = OpenStruct.new({ data: [m1, m2, m3, m4, m5, m6, m7, m8, m9, m10]})
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
      expected = "6"
      expect(actual).to eq(expected)
    end
  end

  describe "finds HoA avaerages" do
    it "finds highest average goals per game while away" do
      actual = @league_statistics.highest_scoring_visitor
      expected = "3"
      expect(actual).to eq(expected)
    end

    it "finds highest average goals per game while home" do
      actual = @league_statistics.highest_scoring_home_team
      expected = "6"
      expect(actual).to eq(expected)
    end

    it "finds lowest average goals per game while away" do
      actual = @league_statistics.lowest_scoring_visitor
      expected = "6"
      expect(actual).to eq(expected)
    end

    it "finds lowest average goals per game while home" do
      actual = @league_statistics.lowest_scoring_home_team
      expected = "3"
      expect(actual).to eq(expected)
    end
  end
end
