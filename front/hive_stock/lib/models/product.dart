import 'package:flutter/material.dart';

class Product {
  String name, sku, image;
  String? class_, category, storageDate, arrivalDate;
  int? quantity, atPreparation, onTheWay;

  Product(
      this.name,
      this.sku,
      this.image,
      {
        this.class_,
        this.category,
        this.storageDate,
        this.arrivalDate,
        this.quantity,
        this.atPreparation,
        this.onTheWay,
      });
}

List<Product> products = [
  Product("Bioglow", "WC-JT-MD-PP", "./assets/images/bioglow.png"),
];