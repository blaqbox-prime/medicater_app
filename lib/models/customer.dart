import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicater_app/models/user.dart';

import 'address.dart';

class Customer extends User {
  String? custId;
  bool? validPrescription;
  String? prescriptionUrl;
  String? idDocUrl;
  String? firstName;
  String? lastName;
  Address? homeAddress;
  String? email;
  String? contact;
  Address? deliveryAddress;

  Customer({
    userId,
    username,
    date_created,
    userType,
    password,
    this.firstName,
    this.lastName,
    this.homeAddress,
    this.custId,
    this.email,
    this.contact,
    this.validPrescription,
    this.prescriptionUrl,
    this.idDocUrl,
  }) : super(
            password: password,
            userId: userId,
            username: username,
            userType: userType,
            date_created: date_created);

  Customer.fromMap(Map<String, dynamic> cust) {
    custId = cust['customer_id'];
    validPrescription = cust['valid_prescription'] == 1 ? true : false;
    prescriptionUrl = cust['prescription'];
    idDocUrl = cust['id_doc'];
    firstName = cust['first_name'];
    lastName = cust['last_name'];
    email = cust['email'];
    contact = cust['contact'];
    homeAddress = Address.fromString(cust['home_address']);
    deliveryAddress = Address.fromString(cust['delivery_address']);

    // used to initialize super class
    userId = cust['userId'];
    username = cust['username'];
    userType = cust['userType'];
    date_created = cust['date_created'];
  }

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'customer_id': custId,
      'valid_prescription': validPrescription == true ? 1 : 0,
      'prescription': prescriptionUrl,
      'id_doc': idDocUrl,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'contact': contact,
      'home_address': homeAddress.toString(),
      'delivery_address': deliveryAddress.toString(),
      'user_id': userId,
      'username': username,
      'date_created': DateFormat('yyyy-MM-dd').format(date_created!),
      'user_type': userType,
    };
  }

  //getter
  String get fullname => "$firstName $lastName";

//update methods
  void setFirstName(name) {
    this.firstName = name;
  }

  void setLastName(name) {
    this.lastName = name;
  }

  void setEmail(newEmail) {
    this.email = newEmail;
    this.setUsername(newEmail);
  }

  void setContact(newContact) {
    this.contact = newContact;
  }

  void uploadPrescription() {}

  void uploadID() {}
}

//sample Customers
List<Customer> sampleCust = [
  // 0 ===============================
  Customer(
    firstName: "James",
    lastName: "Milner",
    contact: "0185478787",
    email: "customer1@gmail.com",
    homeAddress: Address(
        city: "polokwane",
        province: "Limpopo",
        street: "55 DeLaray Avenue",
        suburb: "Bendor",
        zipCode: "8888"),
    custId: "784512369852",
    userId: "0989-436gt-5tt56-vgt53-43frr",
  ),
  // 1 ===============================
  Customer(
    firstName: "Karen",
    lastName: "Mpholoane",
    contact: "0185478787",
    email: "customer2@gmail.com",
    homeAddress: Address(
        city: "polokwane",
        province: "Limpopo",
        street: "5 DeLaray Avenue",
        suburb: "Bendor",
        zipCode: "8888"),
    custId: "090512369852",
    userId: "0000-436gt-5tt56-vgt53-43frr",
  ),
  // 2 ===============================
  Customer(
    firstName: "Miranda",
    lastName: "Cosgrove",
    contact: "0185478787",
    email: "customer4@gmail.com",
    homeAddress: Address(
        city: "polokwane",
        province: "Limpopo",
        street: "5 Gen. Maritz drive",
        suburb: "Bendor",
        zipCode: "8888"),
    custId: "090512369852",
    userId: "8893-436gt-0000-vgt53-43frr",
  ),
];
