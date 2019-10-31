var ReceiptPresenter = /** @class */ (function () {
    function ReceiptPresenter(name, items) {
        this.name = name;
        this.items = items;
        this.name = name;
        this.items = items;
    }
    ReceiptPresenter.prototype.output = function () {
        var subtotal = 0;
        var shipping_fee = 0;
        var tax = 0;
        this.items.forEach(funcion(item), {
            subtotal: subtotal
        });
        var doc = "\n      ==== \u9818\u53CE\u66F8 ====\n      ----------------\n      \u5C0F\u8A08: " + subtotal.floor + "\u5186\n      \u9001\u6599: " + shipping_fee.floor + "\u5186\n      \u6D88\u8CBB\u7A0E: " + tax.floor + "\u5186\n      \u5408\u8A08: " + (subtotal + shipping_fee + tax).floor + "\u5186\n      ================\n    ";
        return doc;
    };
    return ReceiptPresenter;
}());
var DigitalItem = /** @class */ (function () {
    function DigitalItem() {
    }
    DigitalItem.prototype.shipping_fee = function () {
        return 0;
    };
    DigitalItem.prototype.tax = function () {
        this.price * 0.08;
    };
    return DigitalItem;
}());
var ShippingItem = /** @class */ (function () {
    function ShippingItem(weight) {
        this.weight = weight;
        this.weight = weight;
    }
    ShippingItem.prototype.shipping_fee = function () {
        if (this.weight < 1000) {
            return 500.0;
        }
        else {
            return 1000.0;
        }
    };
    ShippingItem.prototype.tax = function () {
        this.price * 0.08;
    };
    return ShippingItem;
}());
var DiscountItem = /** @class */ (function () {
    function DiscountItem(name, price, weight) {
        this.name = name;
        this.price = price;
        this.weight = weight;
        this.name = name;
        this.price = discounted_price(price);
        this.weight = weight;
    }
    DiscountItem.prototype.shipping_fee = function () {
        if (this.weight < 1000) {
            return 500.0;
        }
        else {
            return 1000.0;
        }
    };
    DiscountItem.prototype.tax = function () {
        this.price * 0.08;
    };
    DiscountItem.prototype.discounted_price = function () {
        this.price * ((100 - 20.0) / 100);
    };
    return DiscountItem;
}());
var items = [
    new DigitalItem('Office365シリアル番号', 12000),
    new ShippingItem('ロッキングチェア', 25000, 15000),
    new DiscountItem('美肌マスク', 2400, 200)
];
return new ReceiptPresenter('Relic太郎', items).output();
