import 'package:medicater_app/models/user.dart';
import 'package:medicater_app/models/vehicle.dart';
import 'Order.dart';
import 'address.dart';

class DeliveryMan extends User {
  Vehicle? vehicle;
  String? driverId;
  String? imgUrl;
  Order? currentOrder;
  List<Order>? completedOrders;
  String? firstName;
  String? lastName;
  Address? homeAddress;
  String? contact;
  String? email;
  bool? pdp_permit;
  bool? valid_drivers_lic;
  String? id_doc;
  String? pdp_doc;
  String? drivers_license;

  DeliveryMan({
    userId,
    userType,
    username,
    date_created,
    this.driverId,
    this.vehicle,
    this.contact,
    this.drivers_license,
    this.firstName,
    this.lastName,
    this.email,
    this.homeAddress,
  }) : super(
            userId: userId,
            username: username,
            userType: userType,
            date_created: date_created);

  Map<String, dynamic> toMap() {
    return {
      'driver_id': driverId,
      'vehicle': vehicle!.tostring(),
      'user_id': super.userId,
      'first_name': firstName,
      'last_name': lastName,
      'home_addr': homeAddress.toString(),
      'contact': contact,
      'email': email,
      'pdp_permit': pdp_permit == true ? 1 : 0,
      'valid_drivers_license': valid_drivers_lic == true ? 1 : 0,
      'id_doc': id_doc,
      'pdp_doc': pdp_doc,
      'drivers_licence': drivers_license,
      'username': username,
      'date_created': date_created,
      'user_type': userType,
      'password': super.password
    };
  }

  DeliveryMan.fromMap(Map<String, dynamic> data) {
    userId = data['user_id'];
    username = data['username'];
    userType = data['user_type'];
    date_created = data['date_created'];
    driverId = data['driver_id'];
    firstName = data['first_name'];
    lastName = data['last_name'];
    homeAddress = Address.fromString(data['home_addr']);
    contact = data['contact'];
    email = data['email'];
    vehicle = Vehicle.fromString(data['vehicle']);
    pdp_permit = data['pdp_permit'] == 1 ? true : false;
    valid_drivers_lic = data['valid_drivers_license'] == 1 ? true : false;
    id_doc = data['id_doc'];
    pdp_doc = data['pdp_doc'];
    drivers_license = data['drivers_licence'];
  }

  String get fullName => "$firstName $lastName";
  String get vehicleDetail =>
      "${vehicle!.make} ${vehicle!.model} ${vehicle!.licensePlate}";
}

//sample data
List<DeliveryMan> deliveryMen = [
  DeliveryMan(
      // 0=========================
      driverId: "87898-dybnu43-234cr-vnnio4-32mcc4",
      contact: "0125487854",
      email: "driver@yahoo.com",
      firstName: "Katlego",
      lastName: "Mariba",
      homeAddress: Address(
          city: "Polokwane",
          province: "Limpopo",
          street: "12 Pluto drive ",
          suburb: "Fauna Park",
          zipCode: "0688"),
      userId: "87898-dybnu43-234cr-vnnio4-32mcc4",
      vehicle: ford),
  // 1=============================
  DeliveryMan(
      driverId: "00094-dybnu43-2343cr-vnnio4-32mcc4",
      contact: "0125487854",
      email: "driver2@yahoo.com",
      firstName: "Letago",
      lastName: "Maleka",
      homeAddress: Address(
          city: "Polokwane",
          province: "Limpopo",
          street: "02 juno drive ",
          suburb: "Fauna Park",
          zipCode: "0688"),
      userId: "00094-dybnu43-2343cr-vnnio4-32mcc4",
      vehicle: mazda),
  // 2=============================
  DeliveryMan(
      driverId: "99094-dybnu43-2343cr-vnnio4-32mcc4",
      contact: "0125487854",
      email: "driver3@yahoo.com",
      firstName: "Samuel",
      lastName: "Maluleke",
      homeAddress: Address(
          city: "Polokwane",
          province: "Limpopo",
          street: "02 juno drive ",
          suburb: "Fauna Park",
          zipCode: "0688"),
      userId: "99094-dybnu43-2343cr-vnnio4-32mcc4",
      vehicle: mazda),
];
