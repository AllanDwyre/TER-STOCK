import 'package:flutter/material.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/utils/constants/padding.dart';
import 'package:hive_stock/utils/widgets/snackbars.dart';
import "package:hive_stock/utils/utils/string_extension.dart";

class ProductBody extends StatefulWidget {
  final Product product;

  const ProductBody(this.product, {super.key});

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // Hauteur et largeur totales
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;

    TabController tabController = TabController(length:4, vsync:this);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.asset(widget.product.image),
          Container(
            width: size.width,
            color: colorTheme.onPrimary,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(kDefaultPadding,
                  kDefaultPadding, kDefaultPadding, kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.product.name,
                    style: textTheme.displayMedium
                        ?.copyWith(color: colorTheme.onBackground),
                  ),
                  Text(
                    "Class ${widget.product.class_ ?? "null"} | Sku : ${widget.product.sku}",
                    style: textTheme.titleSmall
                        ?.copyWith(color: colorTheme.onBackground),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: size.width,
            color: colorTheme.onPrimary,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  kDefaultPadding, 0, kDefaultPadding, kDefaultPadding / 2),
              child: Text(
                "Special handling",
                style: textTheme.headlineMedium
                    ?.copyWith(color: colorTheme.onBackground),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                kDefaultPadding, 0, kDefaultPadding, 0),
            child: (widget.product.specialHandling == null)
                ? Text(
                    "No special handling",
                    style: textTheme.titleSmall
                        ?.copyWith(color: colorTheme.outlineVariant),
                  )
                : CustomSnackbar(
                    type: SnackbarType.warning,
                    description:
                        "Please ensure special handling for this package, as it requires temperature maintenant below 5°C throughout transit and storage",
                    title: (widget.product.specialHandling ?? "non renseigné")
                        .capitalize(),
                  ),
          ),
          Container(
            color: colorTheme.onPrimary,
            child: TabBar(
              controller: tabController,
              labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              labelColor: colorTheme.primary,
              unselectedLabelColor: colorTheme.secondary,
              dividerColor: Colors.transparent,
              indicator: UnderlineTabIndicator(borderSide: BorderSide(color:colorTheme.primary, width: 1)),
              tabs: const [
                Tab(text:"Overview"),
                Tab(text:"Purchases"),
                Tab(text:"Adjustement"),
                Tab(text:"History"),
              ],
            ),
          ),
          SizedBox(
            width: size.width,
            height: 300,
            child: TabBarView(
              controller: tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Primary Details",
                        style: textTheme.titleLarge
                            ?.copyWith(color: colorTheme.onBackground),
                      ),
                      Text(
                        "Text",
                        style: textTheme.titleSmall
                            ?.copyWith(color: colorTheme.onBackground),
                      ),
                    ],
                  ),
                ),
                // TODO : factoriser ça ->
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Primary Details",
                        style: textTheme.titleLarge
                            ?.copyWith(color: colorTheme.onBackground),
                      ),
                      Text(
                        "Text",
                        style: textTheme.titleSmall
                            ?.copyWith(color: colorTheme.onBackground),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Primary Details",
                        style: textTheme.titleLarge
                            ?.copyWith(color: colorTheme.onBackground),
                      ),
                      Text(
                        "Text",
                        style: textTheme.titleSmall
                            ?.copyWith(color: colorTheme.onBackground),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Primary Details",
                        style: textTheme.titleLarge
                            ?.copyWith(color: colorTheme.onBackground),
                      ),
                      Text(
                        "Text",
                        style: textTheme.titleSmall
                            ?.copyWith(color: colorTheme.onBackground),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
