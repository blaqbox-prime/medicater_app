import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicater_app/models/pharmacy.dart';
import 'package:medicater_app/providers/locationProvider.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/screens/customer/nav_bar.dart';
import 'package:medicater_app/screens/customer/products_screen.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Future<List<Pharmacy>>? getPharmacies;
  final db = MysqlService();
  // final locationService = LocationProvider();

  @override
  void initState() {
    super.initState();
    getPharmacies = db.getPharmacies("Polokwane");
  }

  @override
  Widget build(BuildContext context) {
    // final locationService = Provider.of<LocationProvider>(context);
    // var city =
    // locationService.getCurrentLocation().then((value) => value.locality);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Explore',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: 38)),
                  TextSpan(
                      text: '\nOur Pharmacies.',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.blueGrey,
                          fontSize: 34)),
                ]),
                softWrap: true,
                textAlign: TextAlign.start,
              ),
              // current city (location)
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.mapMarker,
                    color: Colors.black26,
                    size: 12,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  // FutureBuilder(
                  //     future: city,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         return Text("(${snapshot.data})");
                  //       }
                  //       return Text("(Searching for location...)");
                  //     }),
                ],
              ),
              SizedBox(
                height: 5,
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
              SizedBox(height: 10),
              //List of pharmacies
              FutureBuilder(
                  future: getPharmacies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return pharmaciesList(
                          context: context,
                          pharmacies: snapshot.data as List<Pharmacy>);
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Failed to load pharmacies."),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })
            ]),
          ),
        ),
      ),
    );
  }
}

//pharmacy List Grid View -------------------------------------------------
Widget pharmaciesList({List<Pharmacy>? pharmacies, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 0),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: pharmacies!.map((pharmacy) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              var seller = Provider.of<SellerProvider>(context, listen: false);
              seller.setSeller(pharmacy);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PageCtrl(screen: ProductsScreen(pharmacy))));
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: pharmacy.logo != null
                              ? Image.network(
                                  pharmacy.logo as String,
                                  fit: BoxFit.scaleDown,
                                )
                              : Image.asset(pharmacy.logo ??= "logo.png",
                                  fit: BoxFit.scaleDown))),
                  Text(
                    '${pharmacy.name}',
                    style: TextStyle(fontWeight: FontWeight.w900),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${pharmacy.city}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54, fontSize: 10.0),
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
