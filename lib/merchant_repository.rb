class MerchantRepository
  def initialize(data)
    @data = data
  end

  def loadfile
    data      = CSV.open("./data/merchants_testdata.csv", headers: true, header_converters: :symbol)
    merchants = data.map do |row|
      Merchant.new(row)
    end
    new(merchants)
  end
end
