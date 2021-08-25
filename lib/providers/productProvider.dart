import 'package:flutter/material.dart';
import 'package:medicater_app/models/product.dart';

import 'package:provider/provider.dart';
import '../services/mysql_service.dart';
import 'package:uuid/uuid.dart';

class ProductProvider extends ChangeNotifier {
  final mysqlService = MysqlService();
  Product? product;
  var uuid = Uuid();

//getter
  // Future<Product> getProduct() {}

  // Future<List<Product>> getListing(String sellerId) {}

//setters

  setProduct(Product newProduct) {
    product = newProduct;
  }

  setTitle(String title) {
    product!.name = title;
  }

  setDesc(String desc) {
    product!.description = desc;
  }

  setRec(String recommendation) {
    product!.recommendation = recommendation;
  }

  setCategories(String category) {
    product!.category = category.split(",");
  }

  setPrice(String price) {
    product!.price = double.parse(price);
  }

  clear() {
    product = new Product(
      name: "",
      description: "",
      img: "",
      recommendation: "",
    );
  }

  saveProduct(String pharm_id) {
    if (product!.productId == null) {
      product!.productId = uuid.v4();
    }
    product!.pharm_id = pharm_id;
    mysqlService.saveProduct(product!).then((created) => {
          if (created == true) {print("product saved")}
        });
    clear();
  }
}

//sample data
