require 'pry'
require 'open-uri'
require 'json'
require 'uri'
require 'pry'
require 'test/unit'

class ConvertCurrency
  def get_exchange_rate(currency_type)
  @file = open('http://openexchangerates.org/api/latest.json?app_id=1c4a7b48db7148ebbfccdf5f072f5ae7')
  @j = JSON.load(@file.read)
  @current_currency = @j['rates'][currency_type.upcase]
  end
  
  def convert_to_foreign(currency, amount)
    usd = 1
    foreign = get_exchange_rate(currency)
    foreign * amount.to_i * usd 
  end
  def convert_to_usd(currency, amount)

  end
end

class ConvertCurrencyTest < Test::Unit::TestCase
  def setup
    @converter = ConvertCurrency.new
    @file = open('http://openexchangerates.org/api/latest.json?app_id=1c4a7b48db7148ebbfccdf5f072f5ae7')
    @j = JSON.load(@file.read)
    @compare_c = @j['rates']
  end
  def test_gbp_to_foreign
    assert_equal (@compare_c['GBP'] * 1), @converter.convert_to_foreign("gbp", 1)
  end
  def test_egp_to_foreign
    assert_equal (@compare_c['EGP'] * 1), @converter.convert_to_foreign("egp", 1)
  end
end
