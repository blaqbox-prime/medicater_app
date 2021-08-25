import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/providers/productProvider.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/screens/common/Splash.dart';
import 'package:medicater_app/screens/common/login.dart';
import 'package:medicater_app/screens/common/start_screen.dart';
import 'package:medicater_app/screens/customer/nav_bar.dart';
import 'package:provider/provider.dart';
import 'models/cart.dart';
import 'models/pharmacy.dart';
import 'providers/locationProvider.dart';
import 'providers/orderProvider.dart';
import 'screens/customer/explore_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => SellerProvider(pharmacy: Pharmacy())),
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MediCater',
        theme: ThemeData(
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
          primaryColor: primary_color,
          accentColor: accent_color,
          backgroundColor: bg_color,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StartScreen(),
      ),
    );
  }
}
