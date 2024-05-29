import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_stock/product/views/product_page.dart';
import 'package:hive_stock/scanner/models/scan_response.dart';
import 'package:hive_stock/utils/constants/constants.dart';

class ScanResultFactory {
  ScanResult createResult(ScanResponse response) {
    // if (type == 'Smartphone') {
    return ProductSearch(response: response);
    // return Success(
    //     message:
    //         "The product need to be returned, It arrives in the wrong destination");
    // // } else if (type == 'Laptop') {
    //   return Incoming();
    // } else if (type == 'Headphone') {
    //   return Outgoing();
    // }
    // return null;
  }
}

abstract class ScanResult {
  Widget showDetails(BuildContext context, ScrollController? scrollController);
}

class ProductSearch implements ScanResult {
  final ScanResponse response;
  ProductSearch({required this.response});

  @override
  Widget showDetails(BuildContext context, ScrollController? scrollController) {
    return ProductPage(
      produitId: response.id,
      isFullHeader: false,
      scrollController: scrollController,
    );
  }
}

class Incoming implements ScanResult {
  final ScanResponse response;
  Incoming({required this.response});

  @override
  Widget showDetails(BuildContext context, ScrollController? scrollController) {
    return const Placeholder();
  }
}

class Outgoing implements ScanResult {
  final ScanResponse response;
  Outgoing({required this.response});

  @override
  Widget showDetails(BuildContext context, ScrollController? scrollController) {
    return const Placeholder();
  }
}

class Success implements ScanResult {
  final String message;
  Success({required this.message});

  @override
  Widget showDetails(BuildContext context, ScrollController? _) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Column(
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
    );
  }
}

class Warning implements ScanResult {
  final String message;
  Warning({required this.message});

  @override
  Widget showDetails(BuildContext context, ScrollController? _) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Column(
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
    );
  }
}

class Error implements ScanResult {
  final String message;
  Error({required this.message});

  @override
  Widget showDetails(BuildContext context, ScrollController? _) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Column(
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
    );
  }
}
