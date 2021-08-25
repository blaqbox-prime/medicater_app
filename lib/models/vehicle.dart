class Vehicle {
  String year = "";
  String make = "";
  String model = "";
  String licensePlate = "";

  Vehicle(
      {required this.year,
      required this.make,
      required this.model,
      required this.licensePlate});

  String tostring() {
    return "$make $model $year $licensePlate";
  }

  Vehicle.fromString(String vehicle) {
    var vehicle_array = vehicle.split(" ");
    this.make = vehicle_array[0];
    this.model = vehicle_array[1];
    this.year = vehicle_array[2];
    this.licensePlate = vehicle_array[3];
  }
}

//sample cars
Vehicle ford =
    Vehicle(licensePlate: "25AB89L", make: "Ford", model: "Figo", year: "2007");
Vehicle mazda = Vehicle(
    licensePlate: "66AB89L", make: "Mazda", model: "Mazda3", year: "2010");
Vehicle honda =
    Vehicle(licensePlate: "48AB89L", make: "Honda", model: "i10", year: "2020");
