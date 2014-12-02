require 'date'
class Merchant
  attr_reader :id, :name, :created_at, :updated_at, :repository

  def initialize(row, repository)
    @id           = row[:id].to_i
    @name         = row[:name]
    @created_at = Date.parse(row[:created_at])
    @updated_at = Date.parse(row[:updated_at])
    @repository   = repository
  end

  def items
    repository.find_items(id)
  end

  def invoices
    @invoices ||= repository.find_invoices(id)
  end

  def revenue(date = nil)
    if date.nil?
      @revenue ||= calculate_revenue
    else
      @revenue ||= calculate_revenue(date)
    end
  end

  def calculate_revenue(date = nil)
    if date.nil?
      invoices.reduce(0) do |sum, invoice|
        sum + invoice.revenue
      end
    else
      invoices.reduce(0) do |sum, invoice|
        if date == invoice.created_at
          sum + invoice.revenue
        end
      end
    end
  end
end
