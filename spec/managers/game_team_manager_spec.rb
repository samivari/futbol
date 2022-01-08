require './lib/managers/game_teams_manager'
require './spec/spec_helper'
# require '../../lib/data/game_teams'
require 'RSpec'
require 'ostruct'

RSpec.describe GameTeamsManager do
  before(:each) do
    @game_teams_manager = GameTeamsManager.new('./data/game_teams.csv')
  end
  it 'will generate all the required_data' do
    expect(@game_teams_manager.data.length).to eq(14882)
  end
  it 'will have attributes from the GameTeam class' do
    expect(@game_teams_manager.data.first.game_id).to eq('2012030221')
    expect(@game_teams_manager.data.first.team_id).to eq('3')
    expect(@game_teams_manager.data.first.HoA).to eq('away')
    expect(@game_teams_manager.data.first.result).to eq('LOSS')
    expect(@game_teams_manager.data.first.settled_in).to eq('OT')
    expect(@game_teams_manager.data.first.head_coach).to eq('John Tortorella')
    expect(@game_teams_manager.data.first.goals).to eq(2)
    expect(@game_teams_manager.data.first.shots).to eq(8)
    expect(@game_teams_manager.data.first.tackles).to eq(44)
    expect(@game_teams_manager.data.first.pim).to eq(8)
    expect(@game_teams_manager.data.first.powerPlayOpportunities).to eq(3)
    expect(@game_teams_manager.data.first.powerPlayGoals).to eq(0)
    expect(@game_teams_manager.data.first.faceOffWinPercentage).to eq(44.8)
    expect(@game_teams_manager.data.first.giveaways).to eq(17)
    expect(@game_teams_manager.data.first.takeaways).to eq(7)
  end
end
