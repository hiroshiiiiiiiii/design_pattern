class ReceiptPresenter
  def initialize(name, items)
    @name = name
    @items = items
  end

  def output
    subtotal, shipping_fee, tax = 0, 0 ,0

    @items.each do |item|
      subtotal += item.price
      shipping_fee += item.shipping_fee
      tax += item.tax
    end

    doc = <<~TXT
      ==== 領収書 ====
      #{@name} 様 (日付: #{Time.now.strftime('%Y/%m/%d %H:%M')})
      #{@items.map { |item| item.name + ':' + item.price.to_s + '円' }.join("\n")}
      ----------------
      小計: #{subtotal.floor}円
      送料: #{shipping_fee.floor}円
      消費税: #{tax.floor}円
      合計: #{(subtotal + shipping_fee + tax).floor}円
      ================
    TXT
    doc
  end
end

class ItemInterface
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end

  def shipping_fee
    raise "#{__method__}メソッド定義忘れ"
  end

  def tax
    @price * 0.08
  end
end

class DigitalItem < ItemInterface
  def shipping_fee
    0
  end
end

class ShippingItem < ItemInterface
  def initialize(name, price, weight)
    super(name, price)
    @weight = weight
  end

  def shipping_fee
    if @weight < 1000
      500.0
    else
      1_000.0
    end
  end
end

class DiscountItem < ItemInterface
  DISCOUNT_RATE = 20.0
  def initialize(name, price, weight)
    @name = name
    @price = discounted_price(price)
    @weight = weight
  end

  def shipping_fee
    if @weight < 1000
      250.0
    else
      500.0
    end
  end

  private

  def discounted_price(price)
    price * ((100 - DISCOUNT_RATE) / 100)
  end
end

items = [
  DigitalItem.new('Office365シリアル番号', 12_000.0),
  ShippingItem.new('ロッキングチェア', 25_000.0, 15_000),
  DiscountItem.new('美肌マスク', 2_400.0, 200)
]
puts ReceiptPresenter.new('Relic太郎', items).output