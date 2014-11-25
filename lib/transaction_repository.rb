require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository
  def self.load_file(filename)
    new Repository.load_file(filename, Transaction)
  end
end
