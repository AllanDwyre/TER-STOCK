class Product {
  String name, sku, image;
  String? class_, category, storageDate, arrivalDate, specialHandling;
  int? quantity, atPreparation, onTheWay;

  Product(
    this.name,
    this.sku,
    this.image, {
    this.class_,
    this.category,
    this.storageDate,
    this.arrivalDate,
    this.specialHandling,
    this.quantity,
    this.atPreparation,
    this.onTheWay,
  });
}

List<Product> products = [
  Product(
    "Bioglow",
    "WC-JT-MD-PP",
    "./assets/images(for_test)/bioglow.png",
    specialHandling:"temperature",
  ),
];
