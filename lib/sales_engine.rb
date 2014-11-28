require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'item_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'transaction'
require_relative 'transaction_repository'


class SalesEngine

  attr_reader :merchant_repository, :invoice_repository, :item_repository,
              :invoice_item_repository, :customer_repository, :transaction_repository

  def initialize
    @merchant_repository      = MerchantRepository.new(self) #here self is sales_engine
    @invoice_repository       = InvoiceRepository.new(self)
    @item_repository          = ItemRepository.new(self)
    @invoice_item_repository  = InvoiceItemRepository.new(self)
    @customer_repository      = CustomerRepository.new(self)
    @transaction_repository   = TransactionRepository.new(self)
  end
  def startup
    merchant_repository.load_file("./data/merchants.csv")
    invoice_repository.load_file("./data/invoices.csv")
    item_repository.load_file("./data/items.csv")
    invoice_item_repository.load_file("./data/invoice_items.csv")
    customer_repository.load_file("./data/customers.csv")
    transaction_repository.load_file("./data/transactions.csv")
  end
  def find_invoices_by_customer_id(id)
    invoice_repository.find_all_by_customer_id(id)
  end

end

engine = SalesEngine.new
engine.startup

engine.merchant_repository
engine.invoice_repository
engine.item_repository
engine.invoice_item_repository
engine.customer_repository
engine.transaction_repository
