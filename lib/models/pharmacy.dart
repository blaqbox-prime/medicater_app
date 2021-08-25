import 'dart:core';
import 'package:medicater_app/models/driver.dart';
import 'package:medicater_app/models/user.dart';

import 'address.dart';
import 'order.dart';
import 'product.dart';

class Pharmacy extends User {
  final String? pharm_id;
  final String? name;
  String? contact;
  String? email;
  final String? street;
  final String? suburb;
  final String? city;
  final String? province;
  List<Product>? listing;
  String? logo;
  final String? userid;

  Pharmacy(
      {this.name,
      this.pharm_id,
      this.street,
      this.suburb,
      this.city,
      this.province,
      this.listing,
      this.userid,
      this.logo});

  Map<String, dynamic> toMap() {
    return {
      "pharm_id": pharm_id,
      "name": name,
      "contact": contact,
      "email": email,
      "street": street,
      "suburb": suburb,
      "city": city,
      "province": province,
      'user_id': userid,
      'username': username,
      'date_created': date_created,
      'type': userType,
      'password': password,
    };
  }

  Pharmacy.fromMap(Map<String, dynamic> data)
      : pharm_id = data['pharm_id'],
        name = data['name'],
        contact = data['contact'],
        email = data['email'] ??= "",
        logo = data['logo'],
        street = data['street_addr'] ??= "",
        suburb = data['suburb'],
        city = data['city'],
        province = data['province'],
        userid = data['user_id'];

  //manage products
  loadProducts() {}
  addProduct(Product product) {}
  addProducts(List<Product> products) {}
  deleteProduct(Product product) {}

  //manage orders
  approveOrder(Order order) {}
  cancelOrder(Order order) {}
  rejectOrder(Order order) {}
  // List<Order> getOrderHistory() {}
  // List<Order> getActiveOrders() {}
  // List<Order> getNewOrders() {}
  // List<Order> getCompletedOrders() {}

  assignDriver(DeliveryMan driver, Order order) {
    order.deliveryMan = driver;
  }
}

//sample data
