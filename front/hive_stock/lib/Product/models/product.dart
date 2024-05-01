class Product {
  String name, sku, image;
  String? class_, category, storageDate, arrivalDate, specialHandling;
  double price;
  int quantity, atPreparation, onTheWay;

  Product({
    required this.name,
    required this.sku,
    required this.image,
    required this.price,
    this.class_,
    this.category,
    this.storageDate,
    this.arrivalDate,
    this.specialHandling,
    this.quantity = 0,
    this.atPreparation = 0,
    this.onTheWay = 0,
  });
}

List<Product> products = [
  Product(
    name: "Bioglow",
    sku: "WC-JT-MD-PP",
    image: "./assets/images(for_test)/bioglow.png",
    price: 9.99,
    specialHandling:"temperature",
    quantity: 55,
  ),
  Product(
    name: "Bioglow2",
    sku: "WC-JT-MD-PP2",
    image: "./assets/images(for_test)/bioglow.png",
    price: 9.99,
    specialHandling:"temperature",
  ),
  Product(
    name: "Bioglow3",
    sku: "WC-JT-MD-PP3",
    image: "./assets/images(for_test)/bioglow.png",
    price: 9.99,
    specialHandling:"temperature",
  ),
];
