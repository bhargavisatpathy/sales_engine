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

  def find_items(id) #this is the merchannt_id
    sales_engine.find_items_by_merchant(id)
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_merchant(id)
  end

  def most_revenue(x)
    all.sort { |a, b| b.revenue <=> a.revenue }.take(x)
  end

  def most_items(x)
    all.sort { |a, b| b.items_sold <=> a.items_sold }.take(x)
  end

  def revenue(criteria)
    return 0 if criteria.nil?
    all.reduce(0) { |sum, merchant| sum + merchant.revenue(criteria) }
  end

  def dates_by_revenue(x = nil)
    @dates_by_revenue ||= calculate_dates_by_revenue
    if x.nil?
      @dates_by_revenue
    else
      @dates_by_revenue.take(x)
    end
  end

  def calculate_dates_by_revenue
      date_invoices = all.flat_map { |merchant| merchant.invoices }.group_by { |invoice| invoice.created_at }.to_a
      date_revenue = date_invoices.map { |pair| [pair[0],pair[1].reduce(0) { |sum, invoice| sum + invoice.revenue }]}
      date_revenue.sort { |a, b| b[1] <=> a[1] }.map { |row| row[0] }
  end

  def inspect
    " #{self.class} #{@entities.size} "
  end
end
