import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/models/pharmacy.dart';
import 'package:medicater_app/models/product.dart';
import 'package:medicater_app/providers/productProvider.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/screens/customer/explore_screen.dart';
import 'package:medicater_app/screens/customer/product_detail.dart';
import 'package:medicater_app/screens/customer/products_screen.dart';
import 'package:medicater_app/screens/seller/s_createProduct.dart';
import 'package:medicater_app/screens/seller/s_productDetail.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';
import '../seller/components/s_navigationBar.dart';

class ProductListingScreen extends StatefulWidget {
  final Pharmacy pharmacy;
  ProductListingScreen({required this.pharmacy});

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  List<Product> products = [];
  static const menuItems = [
    "Create new product",
    "Import single product",
    "Import multiple products",
  ];

  static const menuItemsicons = [
    Icon(Icons.create),
    Icon(Icons.add),
    Icon(Icons.add_to_photos),
  ];

  final List<PopupMenuItem> _popUpMenuItems = [
    PopupMenuItem(
        value: menuItems[0],
        child: Row(
          children: [
            menuItemsicons[0],
            SizedBox(
              width: 2.5,
            ),
            Text(menuItems[0])
          ],
        )),
    PopupMenuItem(
        value: menuItems[1],
        child: Row(
          children: [
            menuItemsicons[1],
            SizedBox(
              width: 2.5,
            ),
            Text(menuItems[1])
          ],
        )),
    PopupMenuItem(
        value: menuItems[2],
        child: Row(
          children: [
            menuItemsicons[2],
            SizedBox(
              width: 2.5,
            ),
            Text(menuItems[2])
          ],
        )),
  ];

  var productsList;
  var db = MysqlService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final Pharmacy pharmacy =
        Provider.of<SellerProvider>(context, listen: false).pharmacy;
    productsList = db.getProducts(pharmacy.pharm_id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Product',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black87,
                              fontSize: 38)),
                      TextSpan(
                          text: '\nListing.',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.blueGrey,
                              fontSize: 34)),
                    ]),
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                  Spacer(),
                  PopupMenuButton(
                    onSelected: (value) {
                      if (value == menuItems[0]) {
                        Provider.of<ProductProvider>(context, listen: false)
                            .clear();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateProduct()));
                      }
                    },
                    itemBuilder: (context) => _popUpMenuItems,
                    icon: Icon(Icons.menu),
                  ),
                ],
              ),
              //search Bar ------------------------------------------------------
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300] as Color,
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
                  future: productsList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/undraw_access_denied.svg",
                            height: 150,
                            alignment: Alignment.center,
                          ),
                          Text("Failed to load products."),
                        ],
                      );
                    }
                    if (snapshot.hasData) {
                      return _SellerProductsList(
                          context: context,
                          products: snapshot.data as List<Product>);
                    }
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Loading Products...")
                        ],
                      ),
                    );
                  })
            ]),
          ),
        ),
      ),
    );
  }

//Sellers Product Listings List ---------------------------------------
  Widget _SellerProductsList({required List<Product> products, context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: GridView.count(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: products.map((product) {
          return GridTile(
            child: GestureDetector(
              onTap: () {
                print("Selected Product\n ${product.toMap()}");
                Provider.of<ProductProvider>(context, listen: false)
                    .setProduct(product);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => S_EditProduct(
                          product: product,
                        )));
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
                            ? Image.network(product.img!, fit: BoxFit.cover)
                            : Image.asset("assets/images/logo.png",
                                fit: BoxFit.cover)),
                    Text(
                      '${product.name}',
                      style: TextStyle(fontWeight: FontWeight.w900),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${product.description}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54, fontSize: 10.0),
                    ),
                    Text(
                      'R${product.price}',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  pharmProductsList({required List<Product> products, context}) async {
    Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: GridView.count(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: products.map((product) {
          _buildProductItems(context, product);
        }).toList() as List<Widget>,
      ),
    );
  }

  Widget _buildProductItems(BuildContext context, Product product) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetail(
                    product: product,
                  )));
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
                      ? Image.network(product.img!, fit: BoxFit.cover)
                      : Image.asset("assets/images/logo.png",
                          fit: BoxFit.cover)),
              Text(
                '${product.name}',
                style: TextStyle(fontWeight: FontWeight.w900),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${product.description}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontSize: 10.0),
              ),
              Text(
                'R${product.price}',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ProductList extends StatelessWidget {
//   Future<Product> getProducts(BuildContext context) async {
//     await MysqlService().getProducts();
//   }

//   _buildProduct(BuildContext context, var data) {
//     Product product = Product.fromMap(data.data());
//     return GridTile(
//       child: GestureDetector(
//         onTap: () {
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => ProductDetail(
//                     product: product,
//                   )));
//         },
//         child: Container(
//           padding: EdgeInsets.only(left: 15, bottom: 15),
//           decoration: BoxDecoration(
//             color: Colors.grey[100],
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Expanded(
//                   child: product.img != null
//                       ? Image.network(product.img, fit: BoxFit.cover)
//                       : Image.asset("assets/images/logo.png",
//                           fit: BoxFit.cover)),
//               Text(
//                 '${product.name}',
//                 style: TextStyle(fontWeight: FontWeight.w900),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Text(
//                 '${product.description}',
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(color: Colors.black54, fontSize: 10.0),
//               ),
//               Text(
//                 'R${product.price}',
//                 style: TextStyle(fontWeight: FontWeight.w800),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         FutureBuilder(
//             future: getProducts(context),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: Text("No Data Available Yet"),
//                 );
//               }
//               if (snapshot.hasError) {
//                 return Center(child: Text(snapshot.error));
//               }
//               if (snapshot.hasData) {
//                 return GridView.builder(
//                     shrinkWrap: true,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.75,
//                       mainAxisSpacing: 6.0,
//                       crossAxisSpacing: 6.0,
//                     ),
//                     itemBuilder: (context, index) {
//                       return _buildProduct(context, snapshot.data.docs[index]);
//                     });
//               }
//             }),
//       ],
//     );
//   }
// }
