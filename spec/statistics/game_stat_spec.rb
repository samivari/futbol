require 'spec_helper'
require 'ostruct'
require './lib/statistics/game_statistics'

RSpec.describe GameStatistics do
  before(:each) do
    mock_game_1 = OpenStruct.new({ home_goals: 1, away_goals: 3, total_score: 4, home_win?: false, visitor_win?: true,
                                   tie?: false, season: '20122013', home_team_id: 3, away_team_id: 6 })
    mock_game_2 = OpenStruct.new({ home_goals: 2, away_goals: 6, total_score: 8, home_win?: false, visitor_win?: true,
                                   tie?: false, season: '20122013', home_team_id: 6, away_team_id: 3 })
    mock_game_3 = OpenStruct.new({ home_goals: 3, away_goals: 1, total_score: 4, home_win?: true, visitor_win?: false,
                                   tie?: false, season: '20122013', home_team_id: 3, away_team_id: 6 })
    mock_game_4 = OpenStruct.new({ home_goals: 2, away_goals: 2, total_score: 4, home_win?: false, visitor_win?: false,
                                   tie?: true, season: '20142015', home_team_id: 6, away_team_id: 3 })
    mock_game_manager = OpenStruct.new({ data: [mock_game_1, mock_game_2, mock_game_3, mock_game_4] })
    @game_statistics = GameStatistics.new(mock_game_manager)
  end
  
  describe '#highest_total_score' do
    it 'has a highest winning score' do
      actual = @game_statistics.highest_total_score
      expected = 8
      expect(actual).to eq(expected)
    end
  end

  describe '#lowest_total_score' do
    it 'has a lowest score' do
      actual = @game_statistics.lowest_total_score
      expected = 4
      expect(actual).to eq(expected)
    end
  end

  describe '#percentage_home_wins' do
    it 'has a percentage of home wins' do
      actual = @game_statistics.percentage_home_wins
      expected = 0.25
      expect(actual).to eq(expected)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'has a percentage of visitor wins' do
      actual = @game_statistics.percentage_visitor_wins
      expected = 0.5
      expect(actual).to eq(expected)
    end
  end

  describe '#percentage_ties' do
    it 'has a percentage of ties' do
      actual = @game_statistics.percentage_ties
      expected = 0.25
      expect(actual).to eq(expected)
    end
  end

  describe '#count_of_games_by_season' do
    it 'has a count of games per season' do
      actual = @game_statistics.count_of_games_by_season
      expected = { '20122013' => 3,
                   '20142015' => 1 }
      expect(actual).to eq(expected)
    end
  end

  describe '#average_goals_per_game' do
    it 'has an average of goals per game' do
      actual = @game_statistics.average_goals_per_game
      expected = 5.0
      expect(actual).to eq(expected)
    end
  end

  describe '#average_goals_by_season' do
    it 'has an average of goals by season' do
      actual = @game_statistics.average_goals_by_season
      expected = {
        '20122013' => 5.33,
        '20142015' => 4.0
      }
      expect(actual).to eq(expected)
    end
  end

  before(:each) do
    fake_game_1 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                   season: '20122013', home_team_id: 3, away_team_id: 6 })
    fake_game_2 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                   season: '20122013', home_team_id: 6, away_team_id: 3 })
    fake_game_3 = OpenStruct.new({ home_win?: true, visitor_win?: false,
                                   season: '20142015', home_team_id: 3, away_team_id: 6 })
    fake_game_4 = OpenStruct.new({ home_win?: true, visitor_win?: false,
                                   season: '20142015', home_team_id: 3, away_team_id: 9 })
    fake_game_5 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                   season: '20142015', home_team_id: 3, away_team_id: 9 })
    fake_game_6 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                   season: '20192020', home_team_id: 3, away_team_id: 9 })
    fake_game_manager = OpenStruct.new({ data: [fake_game_1, fake_game_2, fake_game_3, fake_game_4, fake_game_5,
                                                fake_game_6] })
    @fake_game_statistics = GameStatistics.new(fake_game_manager)
  end

  describe '#data_by_season' do
    it 'returns a hash with a season key and an array of Game object values' do
      mock_game_1 = OpenStruct.new({ home_goals: 1, away_goals: 3, total_score: 4, home_win?: false, visitor_win?: true,
                                     tie?: false, season: '20122013', home_team_id: 3, away_team_id: 6 })
      mock_game_2 = OpenStruct.new({ home_goals: 2, away_goals: 6, total_score: 8, home_win?: false, visitor_win?: true,
                                     tie?: false, season: '20122013', home_team_id: 6, away_team_id: 3 })
      mock_game_3 = OpenStruct.new({ home_goals: 3, away_goals: 1, total_score: 4, home_win?: true, visitor_win?: false,
                                     tie?: false, season: '20122013', home_team_id: 3, away_team_id: 6 })
      mock_game_4 = OpenStruct.new({ home_goals: 2, away_goals: 2, total_score: 4, home_win?: false, visitor_win?: false,
                                     tie?: true, season: '20142015', home_team_id: 6, away_team_id: 3 })
      actual = @game_statistics.data_by_season
      expected = { '20122013' => [mock_game_1, mock_game_2, mock_game_3],
                   '20142015' => [mock_game_4] }
      expect(actual).to eq(expected)
    end
  end

  describe '#best_season' do
    it 'returns the name of the season with the highest win percentage for a given team' do
      actual = @fake_game_statistics.best_season(3)
      expected = '20142015'
      expect(actual).to eq(expected)
    end
  end

  describe '#worst_season' do
    it 'returns the name of the season with the lowest win percentage for a given team' do
      actual = @fake_game_statistics.worst_season(3)
      expected = '20192020'
      expect(actual).to eq(expected)
    end
  end

  describe '#group_home_team/group_away_team' do
    it 'groups all games where home_team/away_team matches team_id argument with team_id as key' do
      fake_game_1 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20122013', home_team_id: 3, away_team_id: 6 })
      fake_game_2 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20122013', home_team_id: 6, away_team_id: 3 })
      fake_game_3 = OpenStruct.new({ home_win?: true, visitor_win?: false,
                                     season: '20142015', home_team_id: 3, away_team_id: 6 })
      fake_game_4 = OpenStruct.new({ home_win?: true, visitor_win?: false,
                                     season: '20142015', home_team_id: 3, away_team_id: 9 })
      fake_game_5 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20142015', home_team_id: 3, away_team_id: 9 })
      fake_game_6 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20192020', home_team_id: 3, away_team_id: 9 })
      fake_game_manager = OpenStruct.new({ data: [fake_game_1, fake_game_2, fake_game_3, fake_game_4, fake_game_5,
                                                  fake_game_6] })
      @fake_game_statistics = GameStatistics.new(fake_game_manager)
      actual = @fake_game_statistics.group_home_team(3)
      expected = { 3 => [fake_game_1, fake_game_3, fake_game_4, fake_game_5, fake_game_6] }
      expect(actual).to eq(expected)
      actual_2 = actual = @fake_game_statistics.group_away_team(3)
      expected_2 = { 3 => [fake_game_2] }
      expect(actual_2).to eq(expected_2)
    end
  end

  describe '#group_home_opponents/group_away_opponents' do
    it 'groups opponents with key == opponent team_id and values == game_object array' do
      fake_game_1 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20122013', home_team_id: 3, away_team_id: 6 })
      fake_game_2 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20122013', home_team_id: 6, away_team_id: 3 })
      fake_game_3 = OpenStruct.new({ home_win?: true, visitor_win?: false,
                                     season: '20142015', home_team_id: 3, away_team_id: 6 })
      fake_game_4 = OpenStruct.new({ home_win?: true, visitor_win?: false,
                                     season: '20142015', home_team_id: 3, away_team_id: 9 })
      fake_game_5 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20142015', home_team_id: 3, away_team_id: 9 })
      fake_game_6 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20192020', home_team_id: 3, away_team_id: 9 })
      fake_game_manager = OpenStruct.new({ data: [fake_game_1, fake_game_2, fake_game_3, fake_game_4, fake_game_5,
                                                  fake_game_6] })
      @fake_game_statistics = GameStatistics.new(fake_game_manager)
      away_opponent_hash = @fake_game_statistics.group_away_opponents(3)
      expected = { 6 => [fake_game_1, fake_game_3], 9 => [fake_game_4, fake_game_5, fake_game_6] }
      expect(away_opponent_hash).to eq(expected)
      home_opponent_hash = @fake_game_statistics.group_home_opponents(3)
      expected_2 = { 6 => [fake_game_2] }
      expect(home_opponent_hash).to eq(expected_2)
    end
  end

  describe '#grouped_opponents' do
    it 'creates merged hash with opponent_id as keys and values = array of games opponent plays against team_id' do
      fake_game_1 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20122013', home_team_id: 3, away_team_id: 6 })
      fake_game_2 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20122013', home_team_id: 6, away_team_id: 3 })
      fake_game_3 = OpenStruct.new({ home_win?: true, visitor_win?: false,
                                     season: '20142015', home_team_id: 3, away_team_id: 6 })
      fake_game_4 = OpenStruct.new({ home_win?: true, visitor_win?: false,
                                     season: '20142015', home_team_id: 3, away_team_id: 9 })
      fake_game_5 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20142015', home_team_id: 3, away_team_id: 9 })
      fake_game_6 = OpenStruct.new({ home_win?: false, visitor_win?: true,
                                     season: '20192020', home_team_id: 3, away_team_id: 9 })
      fake_game_manager = OpenStruct.new({ data: [fake_game_1, fake_game_2, fake_game_3, fake_game_4, fake_game_5,
                                                  fake_game_6] })
      @fake_game_statistics = GameStatistics.new(fake_game_manager)

      actual = @fake_game_statistics.grouped_opponents(3)
      expected = { 6 => [fake_game_2, fake_game_1, fake_game_3], 9 => [fake_game_4, fake_game_5, fake_game_6] }
      expect(actual).to eq(expected)
    end
  end

  describe '#favorite_opponent_team_id' do
    it 'returns the team_id of the opponent with the lowest win percentage against team' do
      actual = @fake_game_statistics.favorite_opponent_team_id(3)
      expected = 6
      expect(actual).to eq(expected)
    end

    describe '#rival_team_id' do
      it 'returns the team_id of the opponent with the highest win percentage against team' do
        actual = @fake_game_statistics.rival_team_id(3)
        expected = 9
      end
    end
  end
end
