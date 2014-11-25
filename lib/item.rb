class Item
  attr_reader :id, :name, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(row)
    @id           = row[:id]
    @name         = row[:name]
    @unit_price   = row[:unit_price]
    @merchant_id  = row[:merchant_id]
    @created_at   = row[:created_at]
    @updated_at   = row[:updated_at]
  end
end