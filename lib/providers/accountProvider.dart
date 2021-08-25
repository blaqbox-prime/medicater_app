import 'package:flutter/material.dart';
import 'package:medicater_app/models/address.dart';
import 'package:medicater_app/models/customer.dart';
import 'package:medicater_app/models/driver.dart';
import 'package:medicater_app/models/pharmacy.dart';
import 'package:medicater_app/models/user.dart';
import 'package:medicater_app/models/vehicle.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/screens/customer/explore_screen.dart';
import 'package:medicater_app/screens/customer/nav_bar.dart';
import 'package:medicater_app/screens/seller/nav_bar.dart';
import 'package:medicater_app/services/auth_service.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AccountProvider extends ChangeNotifier {
  final _auth = AuthService();
  final mysqldb = MysqlService();
  final uid = Uuid();
  //user class variables
  String? _userId;
  String? _userType;
  String? _username;
  DateTime? _date_created;

// customer and driver class variables
  String? _driverId;
  String? _custId;
  String? _firstName;
  String? _lastName;
  Address? _homeAddress;
  String? _email;
  String? _contactNo;
  String? _street;
  String? _suburb;
  String? _city;
  String? _province;
  String? _zipCode;
  bool? _validPrescription;
  String? _prescriptionUrl;
  String? _idDocUrl;
  String? _idNo;
  Vehicle? _vehicle;

  // pharmacy variables
  String? _pharmacy_id;
  String? _businessName;
  Address? _businessAddress;
  String? _businessLogo;

  String? _password;
  double? _lattitude;
  double? _longitude;

  Customer? _customer;
  Pharmacy? _pharmacy;
  DeliveryMan? _deliveryMan;
  final uuid = Uuid();

  //getters
  String get email => email;
  String get firstName => firstName;
  String get lastName => lastName;
  Address get homeAddress => homeAddress;
  String get password => _password!;
  Customer get customerDetails => _customer!;
  Pharmacy get pharmacyDetails => _pharmacy!;
  DeliveryMan get deliveryManDetails => _deliveryMan!;
  String get usertype => _userType!;

//setters
  setIdNo(String id) {
    _idNo = id;
  }

  setUsername(String username) {
    _username = username;
  }

  setDriverId(String driverId) {
    _driverId = driverId;
  }

  setHomeAddress() {
    _homeAddress = new Address(
        city: _city,
        street: _street,
        suburb: _suburb,
        zipCode: _zipCode,
        lattitude: _lattitude ??= 0.0,
        longitude: _lattitude ??= 0.0);
  }

  setPassword(String password) {
    _password = password;
  }

  setCustomerId(String cust_id) {
    _custId = cust_id;
  }

  setPharmId(String pharmId) {
    _pharmacy_id = pharmId;
  }

  setBusinessName(String name) {
    _businessName = name;
  }

  setFirstName(String firstName) {
    _firstName = firstName;
  }

  setLastName(String lastName) {
    _lastName = lastName;
  }

  setEmail(String email) {
    _email = email;
  }

  setContactNo(String contact) {
    _contactNo = contact;
  }

  setBusinessAddress() {
    _businessAddress = new Address(
        city: _city,
        street: _street,
        suburb: _suburb,
        zipCode: _zipCode,
        lattitude: _lattitude ??= 0.0,
        longitude: _lattitude ??= 0.0);
  }

  setStreetAddr(String street) {
    _street = street;
  }

  setSuburb(String suburb) {
    _suburb = suburb;
  }

  setCity(String city) {
    _city = city;
  }

  setProvince(String province) {
    _province = province;
  }

  setZipCode(String zipcode) {
    _zipCode = zipcode;
  }

  setLatCoord(String lat) {
    _lattitude = double.parse(lat);
  }

  setLongCoord(String long) {
    _longitude = double.parse(long);
  }

  setVehicle(String vehicle) {
    _vehicle = new Vehicle.fromString(vehicle);
  }

  setVehicleMake(String make) {
    _vehicle!.make = make;
  }

  setVehicleModel(String model) {
    _vehicle!.model = model;
  }

  setVehicleYear(String year) {
    _vehicle!.year = year;
  }

  setVehiclePlate(String plate) {
    _vehicle!.licensePlate = plate;
  }

  User createUser(String userType) {
    final user = new User(
      date_created: DateTime.now(),
      userId: uid.v4(),
      userType: userType,
      username: _username,
      password: password,
    );
    return user;
  }

  Future<bool> createCustomer() {
    final user = createUser("customer");
    final customer = Customer(
      password: user.password,
      custId: _idNo,
      userId: user.userId,
      contact: _contactNo,
      date_created: user.date_created,
      email: _email,
      firstName: _firstName,
      lastName: _lastName,
      homeAddress: _homeAddress,
      userType: "customer",
      username: _email,
    );

    setCustomer(customer);
    Future<bool> created =
        mysqldb.createCustomer(customer).then((result) => result);
    print('Customer created: $created');
    return created;
  }

  Future<bool> createDriver() async {
    final user = createUser("driver");
    final driver = DeliveryMan(
        contact: _contactNo,
        date_created: user.date_created,
        driverId: _idNo,
        email: _email,
        firstName: _firstName,
        lastName: _lastName,
        homeAddress: _homeAddress,
        userId: user.userId,
        userType: user.userType,
        username: user.username,
        vehicle: _vehicle);

    setDeliveryMan(driver);
    return await mysqldb.createDriver(driver);
  }

  Future<bool> createPharmacy() async {
    final user = createUser("pharmacy");
    final pharmacy = new Pharmacy(
      city: _city,
      name: _businessName,
      pharm_id: uid.v4(),
      province: _province,
      street: _street,
      suburb: _suburb,
      userid: user.userId,
    );

    setPharmacy(pharmacy);
    return await mysqldb.createPharmacy(pharmacy);
  }

  Future<void> login(String username, String password,
      {required BuildContext context}) async {
    final user = await _auth.login(username, password);
    if (user != null) {
      if (user.userType == "customer") {
        Customer customer = await mysqldb.getCustomer(user.userId!);
        setCustomer(customer);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PageCtrl()));
      }
      if (user.userType == "driver") {
        DeliveryMan driver = await mysqldb.getDriver(user.userId!);
        setDeliveryMan(driver);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PageCtrl()));
      }
      if (user.userType == "pharmacy") {
        Pharmacy pharmacy = await mysqldb.getPharmacy(user.userId!);
        setPharmacy(pharmacy);
        Provider.of<SellerProvider>(context, listen: false).setSeller(pharmacy);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => S_Navigator()));
      }
    }
  }

  setCustomer(Customer customer) {
    _customer = customer;
  }

  setDeliveryMan(DeliveryMan deliveryMan) {
    _deliveryMan = deliveryMan;
  }

  setPharmacy(Pharmacy pharmacy) {
    _pharmacy = pharmacy;
  }

  void setUserType(String type) {
    _userType = type;
  }
}
