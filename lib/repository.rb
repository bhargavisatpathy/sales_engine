require 'csv'

class Repository
  attr_reader :entities

  def initialize
    @entities = []
  end

  def find_all
    entities
  end

  def find_random
    record_number = rand(0..entities.length - 1)
    entities[record_number]
  end

  protected

  def find_by_X(attribute, criteria)
    find_all_by_X(attribute, criteria).first
  end

  def find_all_by_X(attribute, criteria)
    find_all.select { |entity| entity.send(attribute).downcase == criteria.downcase }
  end

  def find_by_id(id)
    find_by_X(:id, id)
  end

  def find_by_created_at(created_at)
    find_by_X(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by_X(:updated_at, updated_at)
  end
end
