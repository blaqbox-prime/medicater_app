import 'package:flutter/material.dart';

import 'package:medicater_app/models/pharmacy.dart';

class SellerProvider with ChangeNotifier {
  Pharmacy pharmacy;
  SellerProvider({required this.pharmacy});

  String? get id => pharmacy.pharm_id;
  String? get title => pharmacy.name;

  setSeller(Pharmacy newPharmacy) {
    pharmacy = newPharmacy;
  }
}
