import "package:flutter/material.dart";
import "scanner_body.dart";

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ScannerScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: const ScannerBody(),
    );
  }
}
