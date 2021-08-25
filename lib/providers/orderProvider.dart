import 'package:flutter/material.dart';
import 'package:medicater_app/models/address.dart';
import 'package:medicater_app/models/order.dart';
import 'package:medicater_app/models/product.dart';
import 'package:medicater_app/services/mysql_service.dart';

import 'package:uuid/uuid.dart';

class OrderProvider extends ChangeNotifier {
  final _mysqlService = MysqlService();
  Product? product;
  var uuid = Uuid();
  Order order = new Order();

  //getters
  //  DateTime orderDate;
  //  List<Product> orderItems;
  //  double billAmnt;
  //  Address delivAddress;
  //  Address pharmAddress;
  //  Customer customer;
  //  Pharmacy pharmacy;
  //  String orderStatus;

  //setters

  changeDeliveryAddress(Address newAddress) {
    order.delivAddress = newAddress;
    notifyListeners();
  }

  cancelOrder() {
    order.orderStatus = 'cancelled';
  }

  pickUpOrder() async {
    await order.pickUpOrder();
  }

  deliverOrder() async {
    await order.deliverOrder();
  }

  confirmOrder() async {
    await order.confirmOrder();
  }

  orderFulfilled() {
    order.orderStatus = 'fulfilled';
  }

  saveOrder() {
    //if order doesnt exist, create a new one.
    //assign a unique ID, current date and new status
    if (order.orderId == null) {
      order.orderId = uuid.v4();
      order.orderDate = DateTime.now();
      order.orderStatus = "new";
    }
  }

  void send() async {
    try {
      _mysqlService.createOrder(order).then((isCreated) => {
            if (isCreated) {print("order recorded on db")}
          });
    } catch (e) {
      print('failed to send order');
    }
  }

  deleteOrder() async {
    await _mysqlService.deleteOrder(order.orderId!);
  }
}
