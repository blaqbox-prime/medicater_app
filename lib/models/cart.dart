import 'package:flutter/cupertino.dart';
import 'package:medicater_app/models/product.dart';
import 'package:provider/provider.dart';
import 'cartItems.dart';

class Cart extends ChangeNotifier {
  final List<CartItem> cartItems = [];
  double cartTotal = 0.0;
  int items = 0;
  Cart();

  setTotal() {
    cartTotal = 0;
    if (cartItems.length > 0) {
      for (var item in cartItems) {
        cartTotal += item.total;
      }
    }
  }

  incrementProdQuantity({required int productIndex}) {
    cartItems[productIndex].quantity++;
    cartItems[productIndex].total += cartItems[productIndex].product!.price!;
    cartTotal++;
  }

  decrementProdQuantity({required int productIndex}) {
    if (cartItems[productIndex].quantity > 1) {
      cartItems[productIndex].quantity--;
      cartItems[productIndex].total -= cartItems[productIndex].product!.price!;
      cartTotal--;
    }
    if (cartItems[productIndex].quantity == 1) {
      cartItems[productIndex].quantity--;
      cartItems[productIndex].total -= cartItems[productIndex].product!.price!;
      cartTotal--;
      cartItems.removeAt(productIndex);
    }
  }

  removeProduct(int index) {
    cartItems.removeAt(index);
    items -= cartItems[index].quantity;
  }

  clearCart() {
    cartItems.clear();
    items = 0;
  }

  addProduct(Product newProduct, {required int quantity}) {
    bool itemAlreadyInCart = false;
    //check if cart is not empty
    if (items > 0) {
      //check if product is in cart
      for (int i = 0; i > cartItems.length; i++) {
        if (cartItems[i].product!.productId == newProduct.productId) {
          itemAlreadyInCart = true;
          incrementProdQuantity(productIndex: i);
        }
      }
    }

    //if not create new item
    if (itemAlreadyInCart == false) {
      // print(newItem.toMap().toString());
      //print("\n${cartItems.length}\n");
      cartItems.add(CartItem(product: newProduct, quantity: quantity));
      setTotal();
    }
    items++;
    notifyListeners();
  }
}

//sample data

List<CartItem> cartItems = [
  CartItem(product: pnpProducts[0], quantity: 2),
  CartItem(product: pnpProducts[1], quantity: 1),
  CartItem(product: pnpProducts[2], quantity: 2),
];

//Cart sampleCart = Cart(cartItems: cartItems);
