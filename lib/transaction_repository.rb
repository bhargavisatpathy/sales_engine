require 'csv'
require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository
  def load_file
    rows     = CSV.open(filename, headers: true, header_converters: :symbol)
    @entities = rows.map do |row|
      Transaction.new(row, self)
    end
  end

  def find_by_invoice_id(invoice_id)
    find_by_X(:invoice_id, invoice_id)
  end

  def find_by_credit_card_number(credit_card_number)
    find_by_X(:credit_card_number, credit_card_number)
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    find_by_X(:credit_card_expiration_date, credit_card_expiration_date)
  end

  def find_by_result(result)
    find_by_X(:result, result)
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by_X(:invoice_id, invoice_id)
  end

  def find_all_by_credit_card_number(credit_card_number)
    find_all_by_X(:credit_card_number, credit_card_number)
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    find_all_by_X(:credit_card_expiration_date, credit_card_expiration_date)
  end

  def find_all_by_result(result)
    find_all_by_X(:result, result)
  end

  def find_invoice(invoice_id)
    sales_engine.find_invoice(invoice_id)
  end

  def create(input)
    input[:id] = next_id
    input[:created_at] = Time.now.to_s
    input[:updated_at] = Time.now.to_s
    new_row = Transaction.new(input, self)
    @entities << new_row
    new_row.invoice.customer.clear_cache
    new_row.invoice.merchant.clear_cache
    new_row.invoice.invoice_items.each { |invoice_item| invoice_item.item.clear_cache}
    new_row.invoice.clear_cache
    new_row
  end

  def inspect
    " #{self.class} #{@entities.size} "
  end
end
