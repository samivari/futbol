require './spec/spec_helper'
require './lib/csv_reader'
require './lib/managers/game_manager'
require './lib/managers/game_teams_manager'
require './lib/managers/team_manager'
require 'RSpec'



class DummyClass
  attr_accessor :data

  def initialize(path)
  end

end

RSpec.describe CSVReader do
  describe 'game_manager' do
    before(:each) do
      @dc = DummyClass.new('./data/game.csv')
      @dc.extend(CSVReader)
      @dc.data = @dc.generate_data('./data/games.csv', Game)
    end
    it 'can read in data' do
      expect(@dc.data.length).to eq(7441)
    end
    it 'the data is made up of Game Objects' do
      expect(@dc.data.first).to be_instance_of(Game)
    end
    it 'has all of the Game attributes contained in the Game Object' do
      expect(@dc.data.first.away_goals).to eq('2')
      expect(@dc.data.first.away_team_id).to eq('3')
      expect(@dc.data.first.data_time).to eq("5/16/13")
      expect(@dc.data.first.home_goals).to eq('3')
      expect(@dc.data.first.home_team_id).to eq('6')
      expect(@dc.data.first.season).to eq('20122013')
      expect(@dc.data.first.team_id).to eq('2012030221')
      expect(@dc.data.first.type).to eq('Postseason')
      expect(@dc.data.first.venue).to eq("Toyota Stadium")
      expect(@dc.data.first.venue_link).to eq("/api/v1/venues/null")
    end
  end
  describe 'game_teams_manager' do
    before(:each) do
      @dc = DummyClass.new('./data/game_teams.csv')
      @dc.extend(CSVReader)
      @dc.data = @dc.generate_data('./data/game_teams.csv', GameTeam)
    end
    it 'can read in data' do
      expect(@dc.data.length).to eq(14882)
    end
    it 'the data is made up of GameTeam Objects' do
      expect(@dc.data.first).to be_instance_of(GameTeam)
    end
  end
  describe 'team_manager' do
    before(:each) do
      @dc = DummyClass.new('./data/teams.csv')
      @dc.extend(CSVReader)
      @dc.data = @dc.generate_data('./data/teams.csv', Team)
    end
    it 'can read in data' do
      expect(@dc.data.length).to eq(32)
    end
    it 'the data is made up of Team Objects' do
      expect(@dc.data.first).to be_instance_of(Team)
    end
  end
end
