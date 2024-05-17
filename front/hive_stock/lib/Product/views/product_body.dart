import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/product/bloc/product_bloc.dart';
import 'package:hive_stock/utils/constants/constants.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({super.key});

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

    TabController tabController = TabController(length: 4, vsync: this);

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        String productName = state.productdetails?.product.name ?? "-";
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Hero(
                tag: productName,
                child: Image.asset(CustomIcons.productImageTest),
              ),
              Container(
                width: size.width,
                color: colorTheme.onPrimary,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        productName,
                        style: textTheme.displayMedium
                            ?.copyWith(color: colorTheme.onBackground),
                      ),
                      Text(
                        // "Class ${widget.product.class_ ?? "null"} | Sku : ${widget.product.sku}", // TODO : get the class and sku from backend modification
                        "Class A",
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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(
              //       kDefaultPadding, 0, kDefaultPadding, 0),
              //   child: (widget.product.specialHandling == null)
              //       ? Align(
              //           alignment: Alignment.centerLeft,
              //           child: Text(
              //             "No special handling",
              //             style: textTheme.titleSmall
              //                 ?.copyWith(color: colorTheme.outlineVariant),
              //           ),
              //         )
              //       : CustomSnackbar(
              //           type: SnackbarType.warning,
              //           description:
              //               "Please ensure special handling for this package, as it requires temperature maintenant below 5°C throughout transit and storage",
              //           title: (widget.product.specialHandling ?? "non renseigné")
              //               .capitalize(),
              //         ),
              // ),
              Container(
                color: colorTheme.onPrimary,
                child: TabBar(
                  controller: tabController,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                  labelColor: colorTheme.primary,
                  unselectedLabelColor: colorTheme.secondary,
                  dividerColor: Colors.transparent,
                  indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(color: colorTheme.primary, width: 1)),
                  tabs: const [
                    Tab(text: "Overview"),
                    Tab(text: "Purchases"),
                    Tab(text: "Adjustement"),
                    Tab(text: "History"),
                  ],
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height / 2,
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
                                ?.copyWith(color: colorTheme.secondary),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            child: Column(
                              children: [
                                displayDetails(context, widget, "Product Name",
                                    productName),
                                // displayDetails(context, widget, "Product SKU",
                                //     widget.product.sku),
                                // displayDetails(context, widget, "Product Class",
                                //     "${widget.product.class_}"),
                                // displayDetails(context, widget, "Product Category",
                                //     "${widget.product.category}"),
                                // displayDetails(context, widget, "Storage Date",
                                //     "${widget.product.storageDate}"),
                              ],
                            ),
                          ),
                          Text(
                            "Quantity Details",
                            style: textTheme.titleLarge
                                ?.copyWith(color: colorTheme.secondary),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            child: Column(
                              children: [
                                // displayDetails(context, widget, "Quantity",
                                //     "${widget.product.quantity}"),
                                // displayDetails(context, widget, "At preparation",
                                //     "${widget.product.atPreparation}"),
                                // displayDetails(context, widget, "On the way",
                                //     "${widget.product.onTheWay}"),
                                // displayDetails(context, widget, "Arrival date",
                                //     "${widget.product.arrivalDate}"),
                              ],
                            ),
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
      },
    );
  }
}

dynamic displayDetails(context, widget, text1, text2) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Expanded(
        child: Text(
          text1,
          maxLines: 1,
          softWrap: false,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      Expanded(
        child: Text(
          text2,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    ],
  );
}
