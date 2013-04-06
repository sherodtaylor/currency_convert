require 'pry'
require 'open-uri'
require 'json'
require 'uri'
require 'pry'
require 'test/unit'

class ConvertCurrency
  def initialize
    @usd = 1
  end

  def get_exchange_rate(currency_type)
  @file = open('http://openexchangerates.org/api/latest.json?app_id=1c4a7b48db7148ebbfccdf5f072f5ae7')
  @j = JSON.load(@file.read)
  @current_currency = @j['rates'][currency_type.upcase]
  end
  
  def convert_to_foreign(currency, amount)
    foreign = get_exchange_rate(currency)
   # (@usd / (foreign * amount.to_i))
    (amount.to_i * (@usd / foreign))
  end
  def convert_to_usd(currency, amount)
    foreign = get_exchange_rate(currency)
    foreign * amount.to_i * @usd
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
    assert_equal ((1 / @compare_c['GBP']) * 5), @converter.convert_to_foreign("gbp", 5)
  end
  def test_egp_to_foreign
    assert_equal ((1 / @compare_c['EGP']) * 5), @converter.convert_to_foreign("egp", 5)
  end
  def test_usd_to_gbp
    assert_equal (@compare_c['GBP'] * 2), @converter.convert_to_usd("gbp", 2)
  end
  def test_usd_to_gbp
    assert_equal (@compare_c['GBP'] * 9), @converter.convert_to_usd("gbp", 9)
  end
  def test_usd_to_eur
    assert_equal (@compare_c['EUR'] * 323), @converter.convert_to_usd("eur", 323)
  end
end
