require 'csv'
require_relative '../team.rb'
require_relative '../csv_reader'


class TeamManager
  attr_accessor :data
  include CSVReader

  def initialize(path)
    @data = generate_data(path, Team)
  end
end
