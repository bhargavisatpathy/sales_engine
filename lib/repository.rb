require 'csv'

class Repository
  attr_reader :entities
  def initialize(entities)
    @entities = entities
  end

  def self.load_file(filename, entity_type)
    rows     = CSV.open(filename, headers: true, header_converters: :symbol)
    entities = rows.map do |row|
      entity_type.new(row)
    end
    entities
  end

  def find_all
    entities
  end
end
