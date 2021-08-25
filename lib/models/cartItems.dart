import 'package:medicater_app/models/product.dart';

class CartItem {
  Product? product;
  int quantity = 0;
  double total = 0;

  CartItem({required this.product, required this.quantity}) {
    total = quantity * product!.price!;
  }

  Map<String, String> toMap() {
    return {
      'product_id': product!.productId!,
      'price': product!.price.toString(),
      'quantity': quantity.toString(),
      'total': total.toString()
    };
  }

  CartItem.fromMap(Map<String, dynamic> item) {
    quantity = item['quantity'];
    total = item['total'];
  }
}
