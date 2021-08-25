import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/models/pharmacy.dart';
import 'package:medicater_app/models/product.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:medicater_app/screens/customer/product_detail.dart';
import 'package:medicater_app/services/mysql_service.dart';

import 'nav_bar.dart';

class ProductsScreen extends StatefulWidget {
  final Pharmacy pharmacy;
  ProductsScreen(this.pharmacy);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> productList;
  final db = MysqlService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productList = db.getProducts(widget.pharmacy.pharm_id!);
  }

  @override
  Widget build(BuildContext context) {
    final pharmacy = widget.pharmacy;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ScreenTitle(
                text1: pharmacy.name!,
                text2: "\nMedicine \nCabinet",
              ),
              //search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300]!,
                        offset: Offset(0, 2),
                        blurRadius: 5.0)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration.collapsed(hintText: 'Search'),
                    )),
                    FaIcon(
                      FontAwesomeIcons.search,
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              //List of search suggestions
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                height: 30.0,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 30.0,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(categories.elementAt(index),
                            style: TextStyle(color: Colors.white)),
                      );
                    }),
              ),
              //List of Products
              FutureBuilder(
                  future: productList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    if (snapshot.hasData) {
                      return _ProductsList(
                          context: context,
                          products: snapshot.data as List<Product>);
                    }

                    return CircularProgressIndicator();
                  })
            ]),
          ),
        ),
      ),
    );
  }

  //Product List Grid View -------------------------------------------------
  Widget _ProductsList({List<Product>? products, context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: GridView.count(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: products!.map((product) {
          return GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) =>
                            PageCtrl(screen: ProductDetail(product: product))))
                    .then((value) {
                  setState(() {});
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 15, bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: product.img != null
                            ? Image.network(product.img!,
                                alignment: Alignment.center, fit: BoxFit.cover)
                            : Image.asset("assets/images/logo.png",
                                alignment: Alignment.center,
                                fit: BoxFit.cover)),
                    Text(
                      '${product.name}',
                      style: TextStyle(fontWeight: FontWeight.w900),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      '${product.description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54, fontSize: 10.0),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'R${product.price}',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
