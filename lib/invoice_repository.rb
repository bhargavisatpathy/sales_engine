require_relative 'repository'
require_relative 'invoice'


class InvoiceRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, Invoice)
  end
end
