require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, InvoiceItem)
  end
end
