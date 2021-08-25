class Address {
  String? street;
  String? suburb;
  String? city;
  String? province;
  String? zipCode;
  double? lattitude = 0;
  double? longitude = 0;

  Address(
      {this.street,
      this.suburb,
      this.city,
      this.province,
      this.zipCode,
      this.lattitude,
      this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'suburb': suburb,
      'city': city,
      'province': province,
      'zipCode': zipCode,
      'lattitude': lattitude.toString(),
      'longitude': longitude.toString()
    };
  }

  Address.fromMap(Map<String, dynamic> data) {
    street = data['street'];
    suburb = data['suburb'];
    city = data['city'];
    province = data['province'];
    zipCode = data['zipCode'];
    lattitude = data['lattitude'];
    longitude = data['longitude'];
  }

  String asString() {
    return "$street $suburb $city $province $zipCode";
  }

  Address.fromString(String address) {
    final address_array = address.split(",");
    street = address_array[0];
    suburb = address_array[1];
    city = address_array[2];
    province = address_array[3];
    zipCode = address_array[4];
  }

  void setCity(newCity) {
    this.city = newCity;
  }

  void setProvince(newProv) {
    this.province = newProv;
  }

  void setStreet(newStreet) {
    this.street = newStreet;
  }

  void setSuburb(newSuburb) {
    this.suburb = newSuburb;
  }

  void setZipcode(newCode) {
    this.zipCode = newCode;
  }
}
