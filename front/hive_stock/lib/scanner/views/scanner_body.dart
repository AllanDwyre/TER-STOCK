import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_stock/scanner/models/scan_response.dart';
import 'package:hive_stock/scanner/views/scans_factory.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerBody extends StatefulWidget {
  const ScannerBody({super.key});

  @override
  State<ScannerBody> createState() => _ScannerBodyState();
}

class _ScannerBodyState extends State<ScannerBody> {
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: [BarcodeFormat.qrCode, BarcodeFormat.codebar],
  );
  @override
  void initState() {
    _scannerController.stop();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _scannerController.dispose();
  }

  Future _onObjectDetection(BarcodeCapture barcodes) async {
    ScanResponse response = ScanResponse.fromJson(
        jsonDecode(barcodes.barcodes.first.displayValue ?? ""));
    final scanFactory = ScanResultFactory().createResult(response);

    logger.t("new scan made : ${response.type} n°${response.id}");

    await _buildBottomSheet(scanFactory);
    await Future.delayed(Durations.long2);
    await _scannerController.stop();
    unawaited(_scannerController.start());
  }

  Future<dynamic> _buildBottomSheet(ScanResult scanFactory) {
    return showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      // builder: (context) => DraggableScrollableSheet(
      //       expand: false,
      //       shouldCloseOnMinExtent: false,
      //       builder: (context, scrollController) =>
      //           scanFactory.showDetails(context, scrollController),
      //     ));
      builder: (context) => scanFactory.showDetails(context, null),
    );
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
