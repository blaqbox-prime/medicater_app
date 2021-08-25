import 'dart:convert';
import 'dart:io';

import 'package:medicater_app/models/cartItems.dart';
import 'package:medicater_app/models/customer.dart';
import 'package:medicater_app/models/driver.dart';
import 'package:medicater_app/models/order.dart';
import 'package:medicater_app/models/pharmacy.dart';
import 'package:medicater_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:medicater_app/models/user.dart';

class MysqlService {
  MysqlService();

//Account Management

  Future<User> login(String username, String password) async {
    String url = "https://medicater.000webhostapp.com/login.php";
    final response = await http.post(
        Uri.parse('https://medicater.000webhostapp.com/login.php'),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({
          "username": username,
          "password": password,
        }));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return User.fromMap(data);
    } else {
      return User();
    }
  }

  Future<bool> createCustomer(Customer customer) async {
    final url = "https://medicater.000webhostapp.com/createCustomer.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode(customer.toMap()));
    print(response.statusCode);
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> createDriver(DeliveryMan driver) async {
    final url = "https://medicater.000webhostapp.com/createDriverAcc.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode(driver.toMap()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> createPharmacy(Pharmacy pharmacy) async {
    final url = "https://medicater.000webhostapp.com/createPharmacyAcc.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode(pharmacy.toMap()));
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    }
    print(response.body);
    return false;
  }

  Future<Customer> getCustomer(String user_id) async {
    final url = "https://medicater.000webhostapp.com/getCustomer.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({"user_id": user_id}));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return Customer.fromMap(data);
    }
    print('failed to get customer');
    return Customer();
  }

  Future<DeliveryMan> getDriver(String user_id) async {
    final url = "https://medicater.000webhostapp.com/getDriver.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({"user_id": user_id}));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return DeliveryMan.fromMap(data[0]);
    }
    return DeliveryMan();
  }

  Future<Pharmacy> getPharmacy(String user_id) async {
    final url = "https://medicater.000webhostapp.com/getPharmacy.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({"user_id": user_id}));
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      return Pharmacy.fromMap(data);
    }
    return Pharmacy();
  }

//Product Management
  Future<bool> saveProduct(Product product) async {
    try {
      final url = "https://medicater.000webhostapp.com/createProduct.php";
      var response = await http.post(Uri.parse(url),
          headers: {'content-type': "application/x-www-form-urlencoded"},
          body: jsonEncode(product.toMap()));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Product added \n ${response.body}');
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  deletProduct(String productId) async {
    final url = "https://medicater.000webhostapp.com/deleteProduct.php";
    var response =
        await http.post(Uri.parse(url), body: {"product_id": productId});
    if (response.statusCode == 200) {
      print("product deleted: $productId");
      print(response.body);
    } else {
      print("Failed to Delete Product");
      print(response.body);
    }
  }

  Future<Product> getProduct(String product_id) async {
    final url = "https://medicater.000webhostapp.com/getProduct.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({"product_id": product_id}));
    if (response.statusCode == 200) {
      print(response.body);
      var product = jsonDecode(response.body);
      return Product.fromMap(product);
    }
    print(response.body);
    return Product();
  }

  Future<List<Product>> getProducts(String pharmacy_id) async {
    final url = "https://medicater.000webhostapp.com/getProducts.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({"pharmacy": pharmacy_id}));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((product) => Product.fromMap(product)).toList();
    }
    return [];
  }

  Future<void> saveProducts(List<Product> products) async {}

  //Order Management ===========================================================
  Future<List<Order>> fetchOrders(String pharm_id) async {
    final url = "https://medicater.000webhostapp.com/getAllOrders.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({'pharm_id': pharm_id}));

    print(response.body);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<Order> orders = data.map((order) => Order.fromMap(order)).toList();
      orders.forEach((order) async {
        await order.setOrderItems();
        order.setDeliveryMan();
      });
      return orders;
    } else {
      return [];
    }
  }

  Future<List<Order>> getUserOrders(String cust_id) async {
    final url = "https://medicater.000webhostapp.com/getUserOrders.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: {'cust_id': cust_id});

    print(response.body);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<Order> orders = data.map((order) => Order.fromMap(order)).toList();
      orders.forEach((order) async {
        await order.setOrderItems();
        order.setDeliveryMan();
      });
      return orders;
    } else {
      return [];
    }
  }

  Future<bool> createOrder(Order order) async {
    await createOrderItems(order);
    print('sent body > \n ${jsonEncode(order.toMap())}');
    final url = "https://medicater.000webhostapp.com/createOrder.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: order.toMap());
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    }
    return false;
  }

  Future<void> createOrderItems(Order order) async {
    // post items to server
    final url = "https://medicater.000webhostapp.com/createOrderItems.php";
    var response = await http.post(
      Uri.parse(url),
      headers: {'content-type': "application/x-www-form-urlencoded"},
      body: jsonEncode(order.orderItemsMap()),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response);
    } else {
      print('this didnt work : \n >${response.body}');
    }
  }

  Future<void> updateOrderStatus(String new_status, String order_id) async {
    final url = "https://medicater.000webhostapp.com/updateOrderStatus.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: {'new_status': new_status, 'order_id': order_id});
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Success');
      print(response.body);
    } else {
      print('Failed to update order status \n ${response.body}');
    }
  }

  Future<bool> deleteOrder(String order_id) async {
    final url = "https://medicater.000webhostapp.com/deleteOrder.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({'order_id': order_id}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    }
    return false;
  }

  Future<List> getOrderItems(orderId) async {
    final url = "https://medicater.000webhostapp.com/getOrderItems.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({'order_id': orderId}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      List orderItems = await jsonDecode(response.body);
      return orderItems;
    } else {
      return [];
    }
  }

  Future<List<Order>> getNewOrders(String pharm_id) async {
    final url = "https://medicater.000webhostapp.com/getNewOrders.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({"pharm_id": pharm_id}));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((order) => Order.fromMap(order)).toList();
    }
    return [];
  }

  Future<List<Order>> getOngoingOrders(String pharm_id) async {
    final url = "https://medicater.000webhostapp.com/getActiveOrders.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({"pharm_id": pharm_id}));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((order) => Order.fromMap(order)).toList();
    }
    return [];
  }

  Future<List<Order>> getCompletedOrders(String pharm_id) async {
    final url = "https://medicater.000webhostapp.com/getCompletedOrders.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({"pharm_id": pharm_id}));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((order) => Order.fromMap(order)).toList();
    }
    return [];
  }

  Future<List<Order>> getCancelledOrders(String pharm_id) async {
    final url = "https://medicater.000webhostapp.com/getCancelledOrders.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({"pharm_id": pharm_id}));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((order) => Order.fromMap(order)).toList();
    }
    return [];
  }

  //Deliveryman Management

  Future<List<DeliveryMan>> getDrivers(String city) async {
    final url = "https://medicater.000webhostapp.com/getDrivers.php";
    var response = await http.post(Uri.parse(url), body: {
      "city": city,
    });
    if (response.statusCode == 200) {
      print(response.body);
      List data = jsonDecode(response.body);
      return data.map((driver) => DeliveryMan.fromMap(driver)).toList();
    } else {
      print(response.statusCode);
      print(response.body);
    }
    return [];
  }

  // Future<Order> getActiveDelivery(String driver_id) async {
  //   final url = "https://medicater.000webhostapp.com/getActiveDelivery.php";
  //   var response = await http.post(url,
  //       headers: {'content-type': "application/x-www-form-urlencoded"},
  //       body: jsonEncode({"driver_id": driver_id}));
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     return Order.fromMap(data);
  //   }
  // }

  // Future<List<Order>> getFulfilledDeliveries(String driver_id) async {
  //   final url = "https://medicater.000wehostapp.com/getFulfilledDeliveries.php";
  //   var response = await http.post(url,
  //       headers: {'content-type': "application/x-www-form-urlencoded"},
  //       body: jsonEncode({"pharm_id": driver_id}));
  //   if (response.statusCode == 200) {
  //     List data = jsonDecode(response.body);
  //     return data.map((order) => Order.fromMap(order)).toList();
  //   }
  // }

  // Future<int> getDriverDeliveries(String driver_id) async {
  //   final url = "https://medicater.000webhostapp.com/getDriverDeliveries.php";
  //   var response = await http.post(url,
  //       headers: {'content-type': "application/x-www-form-urlencoded"},
  //       body: jsonEncode({"driver_id": driver_id}));
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     return int.parse(data['count']);
  //   }
  // }

  // Future<double> getDriverEarnings(String driver_id) async {
  //   final url = "https://medicater.000webhostapp.com/getDriverEarnings.php";
  //   var response = await http.post(url,
  //       headers: {'content-type': "application/x-www-form-urlencoded"},
  //       body: jsonEncode({"driver_id": driver_id}));
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     return double.parse(data['earnings']);
  //   }
  // }

  //Pharmacy Management

  Future<List<Pharmacy>> getPharmacies(String location) async {
    final url = "https://medicater.000webhostapp.com/getPharmacies.php";
    var response = await http.post(Uri.parse(url),
        headers: {'content-type': "application/x-www-form-urlencoded"},
        body: jsonEncode({"location": location}));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((pharm) => Pharmacy.fromMap(pharm)).toList();
    }
    return [];
  }

  //Uploading files
  void uploadProductImage(
      String fileName, String productId, String base64Image) async {
    final url = "https://medicater.000webhostapp.com/uploadProductImage.php";
    var response = await http.post(Uri.parse(url), body: {
      "image": base64Image,
      "name": fileName,
      "product_id": productId,
    });
    if (response.statusCode == 200) {
      print("Product image uploaded");
      print(response.body);
    } else if (response.statusCode != 200) {
      print("Error \n ${response.body}");
    }
  }

  void assignDriver() {}

  //upload file (prescription/id/logos/)
  void uploadFile(
      {required String fileName,
      String? custId = "empty",
      String? productId = "empty",
      String? driverId = "empty",
      String? pharmId = "empty",
      required String base64Image,
      required String type}) async {
    final url = "https://medicater.000webhostapp.com/uploadFile.php";
    var response = await http.post(Uri.parse(url), body: {
      "image": base64Image,
      "name": fileName,
      "cust_id": custId,
      "product_id": productId,
      "pharm_id": pharmId,
      "driver_id": driverId,
      "type": type,
    });
    if (response.statusCode == 200) {
      print("$type image uploaded");
      print(response.body);
    } else if (response.statusCode != 200) {
      print("Error \n ${response.body}");
    }
  }

  Future<Map<String, dynamic>> getPharmacyAnalyticSummary(
      String pharm_id) async {
    final url =
        "https://medicater.000webhostapp.com/getPharmAnalyticSummary.php";
    var response = await http.post(Uri.parse(url), body: {
      "pharm_id": pharm_id,
    });
    print(jsonDecode(response.body));
    if (response.statusCode == 200)
      return jsonDecode(response.body)[0];
    else
      return {};
  }
}
