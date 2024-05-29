import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_stock/product/views/product_page.dart';
import 'package:hive_stock/scanner/models/scan_response.dart';
import 'package:hive_stock/scanner/views/order_result_page.dart';
import 'package:hive_stock/utils/constants/constants.dart';

enum ResponseStatus { success, warning, error }

class ScanResultFactory {
  ScanResult createResult(ScanResponse response) {
    final status = _handleJson(response);
    switch (status) {
      case -1:
        return Error(
            message:
                "The current barcode doesnt have any related information, or it's corrupted.");
      case 0:
        return ProductScanResult(response: response);
      case 1:
        return OrderScanResult(response: response);
      default:
    }
    return Success(message: "Good product");
  }

  ScanResult createResponce(ResponseStatus status, String? message) {
    switch (status) {
      case ResponseStatus.success:
        return Success(message: message ?? "Unknown Reasons");
      case ResponseStatus.warning:
        return Warning(message: message ?? "Unknown Reasons");
      case ResponseStatus.error:
        return Error(message: message ?? "Unknown Reasons");
      default:
        return Error(message: message ?? "Unknown Reasons");
    }
  }

  int _handleJson(ScanResponse response) {
    if (!["incoming", "outgoing", "product"].contains(response.type)) {
      return -1;
    }
    if (response.type == "product") {
      return 0;
    }
    return 1;
  }
}

abstract class ScanResult {
  Widget showDetails(BuildContext context, ScrollController scrollController);
}

class ProductScanResult implements ScanResult {
  final ScanResponse response;
  ProductScanResult({required this.response});

  @override
  Widget showDetails(BuildContext context, ScrollController scrollController) {
    return ProductPage(
      produitId: response.id!,
      isFullHeader: false,
      scrollController: scrollController,
    );
  }
}

class OrderScanResult implements ScanResult {
  final ScanResponse response;
  OrderScanResult({required this.response});

  @override
  Widget showDetails(BuildContext context, ScrollController scrollController) {
    return IncommingPage(
        scrollController: scrollController, scanResponse: response);
  }
}

class Success implements ScanResult {
  final String message;
  Success({required this.message});

  @override
  Widget showDetails(BuildContext context, ScrollController _) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // ColorScheme colorTheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            CustomIcons.success,
            colorFilter: ColorFilter.mode(
                lightCustomColors.sourceSuccess!, BlendMode.srcIn),
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge
                ?.copyWith(color: lightCustomColors.sourceSuccess),
          ),
        ],
      ),
    );
  }
}

class Warning implements ScanResult {
  final String message;
  Warning({required this.message});

  @override
  Widget showDetails(BuildContext context, ScrollController _) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // ColorScheme colorTheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: lightCustomColors.sourceWarning,
            size: 100,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge
                ?.copyWith(color: lightCustomColors.sourceWarning),
          ),
        ],
      ),
    );
  }
}

class Error implements ScanResult {
  final String message;
  Error({required this.message});

  @override
  Widget showDetails(BuildContext context, ScrollController _) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.report_gmailerrorred,
            color: colorTheme.error,
            size: 100,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(color: colorTheme.error),
          ),
        ],
      ),
    );
  }
}
