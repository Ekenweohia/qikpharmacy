class CheckoutPayload {
  num? amount;
  String? shippingCompanyId;
  List<String>? cartItemIds;

  CheckoutPayload({
    this.amount,
    this.shippingCompanyId,
    this.cartItemIds,
  });

  CheckoutPayload.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    shippingCompanyId = json['shippingCompanyId'];
    cartItemIds = json['cartItemIds'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['shippingCompanyId'] = shippingCompanyId;
    data['cartItemIds'] = cartItemIds;
    return data;
  }
}
