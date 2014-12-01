require 'csv'
require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository
  def load_file
    rows     = CSV.open(filename, headers: true, header_converters: :symbol)
    @entities = rows.map do |row|
      Merchant.new(row, self)
    end
  end

  def find_by_name(name)
    find_by_X(:name, name)
  end

  def find_all_by_name(name)
    find_all_by_X(:name, name)
  end
  def find_items(id)
    sales_engine.find_items_by_merchant(id)
  end
  def find_invoices(id)
    sales_engine.find_invoices_by_merchant(id)
  end
  def most_revenue(x)
    all.sort { |a, b| b.revenue <=> a.revenue }.take(x)
  end
  def inspect
    " #{self.class} #{@entities.size} "
  end
end
