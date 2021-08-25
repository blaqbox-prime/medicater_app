class Sale {
  String? saleId;
  String? orderId;
  double? billAmount;
  double? deliveryFee;
  double? totalCost;

  Sale({saleId, orderId, billAmount, deliveryFee, totalCost});

  Sale.fromMap(Map<String, dynamic> data) {
    saleId = data["sale_id"];
    orderId = data["order_id"];
    billAmount = data["bill_amount"];
    deliveryFee = data["delivery_fee"];
    totalCost = data["total_cost"];
  }

  Map<String, dynamic> toMap() {
    return {
      'sale_id': saleId,
      'order_id': orderId,
      'billAmount': billAmount,
      'delivery_fee': deliveryFee,
      'totalCost': totalCost,
    };
  }
}
