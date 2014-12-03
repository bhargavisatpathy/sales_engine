require 'csv'

class Repository
  attr_reader :sales_engine, :filename

  def initialize(sales_engine, filename)
    @sales_engine = sales_engine
    @filename = filename
  end

  def entities
    @entities ||= load_file
  end

  def load_file # override this in subclasses to get proper fileloading
    []
  end

  def all
    entities
  end

  def random
    record_number = rand(0..entities.length - 1)
    entities[record_number]
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

  def next_id
    return 1 if all.empty?
    all.max_by { |entity| entity.id }.id + 1
  end

  protected

  def find_by_X(attribute, criteria)
    all.detect { |entity| entity.send(attribute).to_s.downcase == criteria.to_s.downcase }
  end

  def find_all_by_X(attribute, criteria)
    all.select { |entity| entity.send(attribute).to_s.downcase == criteria.to_s.downcase }
  end
  def inspect
    " #{self.class} #{@entities.size} "
  end
end
