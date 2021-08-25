class Product {
  String? productId;
  String? name;
  String? description;
  String? recommendation;
  List<String>? category = [];
  String? img;
  double? price = 0.0;
  String? pharm_id;
  bool? prescription_required = false;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': name,
      'description': description,
      'recommendation': recommendation,
      'img': img,
      'price': price,
      'pharm_id': pharm_id,
      'prescription_required': prescription_required == true ? 1 : 0
    };
  }

  Product.fromMap(Map<String, dynamic> data) {
    productId = data['listing_id'];
    name = data['title'];
    description = data['description'];
    recommendation = data['recommendation'];
    prescription_required = data['prescription_required'] == 1 ? true : false;
    img = data['img'];
    price = double.parse(data['price']);
    pharm_id = data['pharm_id'];
  }

  Product(
      {this.productId,
      this.name,
      this.price,
      this.description,
      this.img,
      this.recommendation,
      this.prescription_required,
      this.pharm_id}) {
    if (this.img == null) {
      this.img = '';
    }
  }
}

//sample product listings
//clicks
List<Product> clicksProducts = [
  Product(
      name: "Topzolii",
      description: "Multivitamin supplements",
      price: 132.99,
      img: 'lib/assets/images/logo.png',
      productId: "Topz10",
      recommendation: 'Take as needed. Do not exceed 8 doese per day'),
  Product(
      name: "AsthaVent",
      description: "Breath naturally and inhale",
      price: 143.99,
      img: 'lib/assets/images/logo.png',
      productId: "Astha10",
      recommendation: 'Take as needed. Do not exceed 8 doese per day'),
  Product(
      name: "Aspring",
      description: "Something thats good for you",
      price: 149.99,
      img: 'lib/assets/images/logo.png',
      productId: "Aspr10",
      recommendation: 'Take as needed. Do not exceed 8 doese per day'),
];

//pnp pharmacy
List<Product> pnpProducts = [
  Product(
      name: "Pharmaton Vitality",
      description:
          "Pharmaton is the only clinically proven product to relieve Daily Fatigue and is supported by more than 30 clinical trials. Pharmaton Capsules balance out energy levels throughout the day - reducing Daily Fatigue, exhaustion and hence improving physical and mental performance.",
      price: 149.99,
      img: 'assets/images/logo.png',
      productId: "Pharm10",
      recommendation:
          'Start by taking Pharmaton® Vitality Capsules for 4 weeks. If, after 4 weeks treatment, you are starting to feel better, you may continue to take Pharmaton® Vitality Capsules for up to 12 weeks.'),
  Product(
    name: "Benylin for Flu",
    description: "Multivitamin supplements",
    price: 149.99,
    img: 'assets/images/logo.png',
    productId: "Beny10",
    recommendation: 'Take as needed. Do not exceed 8 doese per day',
  ),
  Product(
      name: "Grandpa Rapid Relief",
      description: "Multivitamin supplements",
      price: 149.99,
      img: 'assets/images/logo.png',
      productId: "Gran10",
      recommendation: 'Take as needed. Do not exceed 8 doese per day'),
];
//dischem pharmacy
List<Product> dischemProducts = [
  Product(
      name: "Magic Meds",
      description: "magic medicine here",
      price: 132.99,
      img: 'assets/images/logo.png',
      productId: "Topz10",
      recommendation: 'Take as needed. Do not exceed 8 doese per day'),
  Product(
      name: "Myprodo",
      description: "Arthritis relief",
      price: 13.99,
      img: 'assets/images/logo.png',
      productId: "Mypro10",
      recommendation: 'Take as needed. Do not exceed 8 doese per day'),
  Product(
      name: "inHouse Cough mixture",
      description: "get well soon",
      price: 149.99,
      img: 'assets/images/logo.png',
      productId: "Cough10",
      recommendation: 'Take as needed. Do not exceed 8 doese per day'),
];

//sample catagories
Set<String> categories = {
  'Vitamins',
  'Colds and fever',
  'MultiVitamins',
  'Sores',
  'Muscle and Joint pains',
  'flu',
  'Dry cough',
  'Inflammation',
  'AntiSeptic'
};
