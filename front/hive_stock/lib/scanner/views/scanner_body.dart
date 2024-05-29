import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_stock/product/views/product_page.dart';
import 'package:hive_stock/scanner/models/scan_response.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerBody extends StatefulWidget {
  const ScannerBody({super.key});

  @override
  State<ScannerBody> createState() => _ScannerBodyState();
}

class _ScannerBodyState extends State<ScannerBody> {
  late MobileScannerController _scannerController;

  @override
  void initState() {
    _scannerController = MobileScannerController(
        // ici, on veut rechercher un élément(produit ou order)
        detectionSpeed: DetectionSpeed.noDuplicates,
        autoStart: true,
        formats: [BarcodeFormat.qrCode, BarcodeFormat.codebar]);
    super.initState();
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future _onObjectDetection(BarcodeCapture barcodes) async {
    ScanResponse response = ScanResponse.fromJson(
        jsonDecode(barcodes.barcodes.first.displayValue ?? ""));

    logger.t("new scan made : ${response.type} n°${response.id}");

    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (context) => response.type == "product"
            ? ProductPage(produitId: response.id)
            : ProductPage(produitId: response.id) // TODO : change to orderPage
        );
    await Future.delayed(Durations.long2);

    setState(() {
      // _scannerController.stop();
      //_scannerController.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: _scannerController,
      onDetect: _onObjectDetection,
      errorBuilder: _onScanErrorMethod,
    );
  }

  Center _onScanErrorMethod(
      BuildContext context, MobileScannerException exeption, Widget? widget) {
    logger.e(exeption.errorDetails?.message ?? "Error occured");
    return Center(
      child: widget ?? Text(exeption.errorDetails?.message ?? "Error occured"),
    );
  }
}
