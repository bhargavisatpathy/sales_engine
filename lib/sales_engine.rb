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

  def initialize
    @merchant_repository      = Merchant.new
    @invoice_repository       = Invoice.new
    @item_repository          = Item.new
    @invoice_item_repository  = InvoiceItem.new
    @customer_repository      = Customer.new
    @transaction_repository   = Transaction.new
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
