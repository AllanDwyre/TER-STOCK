import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_stock/order/models/commande_details.dart';
import 'package:hive_stock/utils/constants/constants.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard(
      {super.key, required this.details, this.onTap, this.isFromScan = false});
  final CommandeDetails details;
  final bool isFromScan;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return ListTile(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Image border
        child: Image.asset(CustomIcons.productImageTest),
      ),
      tileColor: const Color.fromARGB(255, 234, 239, 241),
      title: Text(
        details.nameProduct ?? "-",
        style: textTheme.titleMedium?.copyWith(color: colorTheme.secondary),
      ),
      subtitle: Text("Quantity ${details.quantity}"),
      trailing: isFromScan ? SvgPicture.asset(CustomIcons.scan) : null,
      onTap: onTap,
    );
  }
}
