require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, Transaction)
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

  def find_all_by_invoice_id(invoice_id)
    find_all_by_X(:invoice_id, invoice_id)
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

  def find_all_by_invoice_id(invoice_id)
    find_all_by_X(:invoice_id, invoice_id)
  end
end
