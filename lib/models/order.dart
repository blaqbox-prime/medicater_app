import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicater_app/models/product.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'address.dart';
import 'cartItems.dart';
import 'customer.dart';
import 'driver.dart';
import 'pharmacy.dart';
import 'cart.dart';

class Order {
  String? orderId;
  DateTime? orderDate;
  List<CartItem>? orderItems;
  double? billAmnt;
  Address? delivAddress;
  Customer? customer;
  Pharmacy? pharmacy;
  String? orderStatus;
  DeliveryMan? deliveryMan;
  // ignore: deprecated_member_use
  List? orderItemsMapList = [];
  bool? is_delivery;
  String? customer_id;
  String? pharm_id;

  Order({
    this.deliveryMan,
    this.orderDate,
    this.orderStatus,
    this.orderId,
    this.orderItems,
    this.billAmnt,
    this.delivAddress,
    this.customer,
    this.pharmacy,
  });

  Map<String, dynamic> orderItemsMap() {
    List items = orderItems!.map((item) => item.toMap()).toList();
    return {
      "order_id": orderId!,
      "items": items,
    };
  }

  Order.fromMap(Map<String, dynamic> data) {
    orderId = data['order_id'] as String;
    orderDate = DateTime.tryParse(data['order_date']);
    billAmnt = double.parse(data['bill_amount']);
    is_delivery = int.parse(data['is_delivery']) == 1 ? true : false;
    delivAddress =
        data['delivery_address'] != null || data['delivery_address'] != ""
            ? Address.fromString(data['delivery_address'])
            : new Address(
                city: "not set",
                province: "not set",
                street: "not set",
                suburb: "not set",
                zipCode: "not set");
    customer_id = data['customer_id'] as String;
    pharm_id = data['pharm_id'] as String;
    orderStatus = data['order_status'] as String;
    customer = new Customer(
      contact: data['contact'] as String,
      custId: data['customer_id'] as String,
      email: data['email'] as String,
      firstName: data['first_name'] as String,
      lastName: data['last_name'] as String,
      homeAddress: data['home_address'] != null || data['home_address'] != ""
          ? new Address.fromString(data['home_address'])
          : new Address(
              city: "not set",
              province: "not set",
              street: "not set",
              suburb: "not set",
              zipCode: "not set"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'order_date': DateFormat('yyyy-MM-dd').format(orderDate!),
      'bill_amount': "$billAmnt",
      'delivery_address': delivAddress!.asString(),
      'customer_id': customer!.custId,
      'pharm_id': pharmacy!.pharm_id,
      'order_status': orderStatus,
      'driver_id': deliveryMan!.driverId,
      'is_delivery': is_delivery == true ? '1' : '0',
    };
  }

  String get order_date {
    var day;
    var month;
    //format
    orderDate!.day > 9
        ? day = orderDate!.day.toString()
        : day = "0${orderDate!.day}";
    orderDate!.month > 9
        ? month = orderDate!.month.toString()
        : month = "0${orderDate!.month}";

    return "$day-$month-${orderDate!.year}";
  }

  String get order_time {
    var minute;
    var hour;
    orderDate!.minute > 9
        ? minute = orderDate!.minute.toString()
        : minute = "0${orderDate!.minute}";
    orderDate!.hour > 9
        ? hour = orderDate!.hour.toString()
        : hour = "0${orderDate!.hour}";

    return "$minute:$hour";
  }

  setOrderItems() async {
    List<CartItem> cartItems = [];

    var orderItems = await MysqlService().getOrderItems(this.orderId);
    orderItems.forEach((orderItem) async {
      Product product =
          await MysqlService().getProduct(orderItem['listing_id']);
      print('product > ${product.price}');
      CartItem cartItem = CartItem(
          product: product, quantity: int.tryParse(orderItem['quantity'])!);
      print('cartItem > $cartItem');
      cartItems.add(cartItem);
    });

    this.orderItems = cartItems;
  }

  setDeliveryMan({DeliveryMan? deliveryMan}) {
    if (deliveryMan != null) {
      this.deliveryMan = deliveryMan;
    } else {
      this.deliveryMan = deliveryMen[0];
    }
  }

  pickUpOrder() {
    this.orderStatus = 'on pick-up';
    MysqlService().updateOrderStatus('on pick-up', this.orderId!);
  }

  cancelOrder() async {
    this.orderStatus = 'cancelled';
    await MysqlService().updateOrderStatus('cancelled', this.orderId!);
  }

  confirmOrder() async {
    this.orderStatus = 'Processing';
    await MysqlService().updateOrderStatus('processing', this.orderId!);
  }

  deliverOrder() async {
    this.orderStatus = 'on delivery';
    await MysqlService().updateOrderStatus('on delivery', this.orderId!);
  }

  orderFulfilled() async {
    this.orderStatus = 'fulfilled';
    await MysqlService().updateOrderStatus('fulfilled', this.orderId!);
  }

  Color statusClr() {
    switch (this.orderStatus) {
      case "new order":
        return cl_newOrder;
        break;
      case "processing":
        return cl_processing;
        break;
      case "fulfilled":
        return cl_fulfilled;
        break;
      case "cancelled":
        return cl_cancelled;
        break;
      default:
        return Colors.black;
    }
  }
}

//sample data
List<Order> sampleOrders = [
  Order(
    // 0 =============================================
    billAmnt: 249.99,
    orderId: "65bf4335-b886-4680-a788-63bfee35fc38",
    orderDate: DateTime.now(),
    orderItems: cartItems,
    orderStatus: "new order",
    customer: sampleCust[0],
    delivAddress: sampleCust[0].homeAddress,
    deliveryMan: deliveryMen[0],
  ),
  // 0 =============================================
  Order(
    billAmnt: 449.99,
    orderId: "0000-324rfv-r44r-134rtg-567523",
    orderDate: DateTime.now(),
    orderItems: cartItems,
    orderStatus: "new order",
    customer: sampleCust[0],
    delivAddress: sampleCust[0].homeAddress,
    deliveryMan: deliveryMen[0],
  ),
  // 0 =============================================
  Order(
    billAmnt: 249.99,
    orderId: "96f5f906-12c1-47e2-8a5f-0fc518c8bea2",
    orderDate: DateTime.now(),
    orderItems: cartItems,
    orderStatus: "new order",
    customer: sampleCust[1],
    delivAddress: sampleCust[1].homeAddress,
    deliveryMan: deliveryMen[0],
  ),
  // 0 =============================================
  Order(
    billAmnt: 629.99,
    orderId: "436ffad4-ebdc-479b-98ea-cab45ecd1c5a",
    orderDate: DateTime.now(),
    orderItems: cartItems,
    orderStatus: "new order",
    customer: sampleCust[0],
    delivAddress: sampleCust[0].homeAddress,
    deliveryMan: deliveryMen[1],
  ),
  // 0 =============================================
  Order(
    billAmnt: 849.99,
    orderId: "e0fd0ea1-7d20-443a-916e-237cdfbe309d",
    orderDate: DateTime.now(),
    orderItems: cartItems,
    orderStatus: "processing",
    customer: sampleCust[1],
    delivAddress: sampleCust[1].homeAddress,
    deliveryMan: deliveryMen[1],
  ),
  // 0 =============================================
  Order(
    billAmnt: 699.99,
    orderId: "ffebe6ff-3b80-4a83-81e7-c32734549519",
    orderDate: DateTime.now(),
    orderItems: cartItems,
    orderStatus: "fulfilled",
    customer: sampleCust[2],
    delivAddress: sampleCust[2].homeAddress,
    deliveryMan: deliveryMen[2],
  ),
];
