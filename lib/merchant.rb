class Merchant
  attr_reader :id, :name, :created_at, :updated_at, :repository

  def initialize(row, repository)
    @id           = row[:id].to_i
    @name         = row[:name]
    @created_at   = row[:created_at]
    @updated_at   = row[:updated_at]
    @repository   = repository
  end

  def items
    repository.find_items(id)
  end

  def invoices
    @invoices ||= repository.find_invoices(id)
  end

  def revenue
    @revenue ||= calculate_revenue
  end

  def calculate_revenue
    invoices.reduce(0) do |sum, invoice|
      sum + invoice.revenue
    end
  end
end
