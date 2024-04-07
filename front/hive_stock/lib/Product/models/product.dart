class Product {
  String name, sku, image;
  String? class_, category, storageDate, arrivalDate, specialHandling;
  int? price, atPreparation, onTheWay;
  int quantity;

  Product({
    required this.name,
    required this.sku,
    required this.image,
    this.class_,
    this.category,
    this.storageDate,
    this.arrivalDate,
    this.specialHandling,
    this.price,
    this.atPreparation,
    this.onTheWay,
    this.quantity = 0,
  });
}

List<Product> products = [
  Product(
    name: "Bioglow",
    sku: "WC-JT-MD-PP",
    image: "./assets/images(for_test)/bioglow.png",
    specialHandling:"temperature",
    quantity: 55,
  ),
  Product(
    name: "Bioglow2",
    sku: "WC-JT-MD-PP2",
    image: "./assets/images(for_test)/bioglow.png",
    specialHandling:"temperature",
  ),
  Product(
    name: "Bioglow3",
    sku: "WC-JT-MD-PP3",
    image: "./assets/images(for_test)/bioglow.png",
    specialHandling:"temperature",
  ),
];
