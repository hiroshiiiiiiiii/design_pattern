class ReceiptPresenter {
  name: string;
  items: ItemInterface[];

  constructor(public name: string, public items: ItemInterface[]) {
    this.name = name;
    this.items = items;
  }

  output() {
    let subtotal= 0;
    let shipping_fee = 0;
    let tax = 0;

    this.items.forEach(funcion(item) {
      subtotal = subtotal + item.price,
      // shipping_fee = shipping_fee + item.shipping_fee,
      // tax = tax + item.tax,
    });

    const doc = `
      ==== 領収書 ====
      ----------------
      小計: ${subtotal.floor}円
      送料: ${shipping_fee.floor}円
      消費税: ${tax.floor}円
      合計: ${(subtotal + shipping_fee + tax).floor}円
      ================
    `
    return doc;
  }


}

interface ItemInterface {
  name: string;
  price: number;
  shipping_fee(): number;
  tax(): number;
}

class DigitalItem implements ItemInterface {
  shipping_fee() {
    return 0;
  }

  tax() {
    this.price * 0.08
  }
}

class ShippingItem implements ItemInterface {
  weight: number;
  constructor(public weight: number) {
    this.weight = weight;
  }

  shipping_fee() {
    if (this.weight < 1000) {
      return 500.0;
    } else {
      return 1000.0;
    }
  }

  tax() {
    this.price * 0.08
  }
}

class DiscountItem implements ItemInterface {
  weight: number;
  constructor(public name: string, public price: number, public weight: number) {
    this.name = name;
    this.price = discounted_price(price);
    this.weight = weight;
  }

  shipping_fee() {
    if (this.weight < 1000) {
      return 500.0;
    } else {
      return 1000.0;
    }
  }

  tax() {
    this.price * 0.08
  }

  private discounted_price() {
    this.price * ((100 - 20.0) / 100)
  }
}

let items: ItemInterface[] = [
  new DigitalItem('Office365シリアル番号', 12_000.0),
  new ShippingItem('ロッキングチェア', 25_000.0, 15_000),
  new DiscountItem('美肌マスク', 2_400.0, 200)
]

return new ReceiptPresenter('Relic太郎', items).output();
