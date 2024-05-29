import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/product/bloc/product_bloc.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/utils/widgets/snackbars.dart';

import '../../utils/widgets/custom_tab_bar.dart';

class ProductBody extends StatefulWidget {
  const ProductBody(
      {super.key, required this.isFullHeader, this.scrollController});
  final bool isFullHeader;
  final ScrollController? scrollController;

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: ((context, state) {
        Product? product = state.productdetails?.product;
        return CustomScrollView(
          controller: widget.scrollController,
          slivers: [
            SliverVisibility(
              visible: widget.isFullHeader,
              sliver: _ProductAppBar(
                productName: state.productdetails?.product.name,
              ),
            ),
            _ProductHeader(product: product, isFullHeader: widget.isFullHeader),
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              primary: false,
              title: CustomTabBar(
                tabController: tabController,
                tabs: const [
                  Tab(text: "Overview"),
                  Tab(text: "Purchases"),
                  Tab(text: "Adjustement"),
                  Tab(text: "History"),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: size.height,
                width: size.width,
                padding: defaultPagePadding.copyWith(top: 20),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    _Overview(product: product),
                    const _Purchases(),
                    const _Adjustement(),
                    const _History(),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

class _History extends StatelessWidget {
  const _History({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('data');
  }
}

class _Adjustement extends StatelessWidget {
  const _Adjustement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('data');
  }
}

class _Purchases extends StatelessWidget {
  const _Purchases({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('data');
  }
}

class _Overview extends StatelessWidget {
  const _Overview({this.product});

  final Product? product;

  Text InformationSection(
      {required String title, required BuildContext context}) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Theme.of(context).colorScheme.secondary),
    );
  }

  String checkValue(String? value) => value ?? '-';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //TODO : sync informations
      children: [
        InformationSection(title: 'Primary Details', context: context),
        _TableRowProduct(title: 'Name', value: checkValue(product?.name)),
        _TableRowProduct(
            title: 'Product Sku', value: checkValue(product?.barcode)),
        _TableRowProduct(
            title: 'Product Class', value: checkValue(product?.dimensions)),
        _TableRowProduct(
            title: 'Product Price',
            value: checkValue(product?.unitPrice.toString())),
        const _TableRowProduct(title: 'Product category', value: 'Pharmacy'),
        const _TableRowProduct(title: 'Storage date', value: '15/02/2023'),
        InformationSection(title: 'Quantity Details', context: context),
        const _TableRowProduct(title: 'Quantity', value: '20'),
        const _TableRowProduct(title: 'At preparation', value: '50'),
        const _TableRowProduct(title: 'On the way', value: '150'),
        const _TableRowProduct(title: 'Arrival Date', value: '15/06/2023'),
        const _TableRowProduct(title: 'Threshold Value', value: 'auto'),
        InformationSection(title: 'Supplier Details', context: context),
        const _TableRowProduct(title: 'Supplier Name', value: 'Phara LDC'),
        const _TableRowProduct(
            title: 'Supplier Contact', value: '07 67 02 73 76'),
      ],
    );
  }
}

class _ProductHeader extends StatelessWidget {
  const _ProductHeader({
    required this.product,
    required this.isFullHeader,
  });

  final Product? product;
  final bool isFullHeader;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: defaultPagePadding.copyWith(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductBasicInformation(
                product: product, isFullHeader: isFullHeader),
            const SizedBox(height: 10),
            Visibility(
              visible:
                  (product?.productId ?? 1) % 2 == 0, //TODO : change that lol
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Special handling",
                    style: textTheme.headlineMedium
                        ?.copyWith(color: colorTheme.onBackground),
                  ),
                  const SizedBox(height: 10),
                  // ? : Sliver List ?
                  CustomSnackbar(
                    type: SnackbarType.warning,
                    title: 'Temperature',
                    description:
                        'Please ensure special handling for this package, as it requires  temperature maintenance below 5°C throughout transit and storage.',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductBasicInformation extends StatelessWidget {
  const _ProductBasicInformation({
    required this.product,
    required this.isFullHeader,
  });

  final Product? product;
  final bool isFullHeader;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Builder(builder: (context) {
      if (isFullHeader) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product?.name ?? '-',
              style: textTheme.headlineLarge,
            ),
            const SizedBox(height: 5),
            Text(
              // "Class ${widget.product.class_ ?? "null"} | Sku : ${widget.product.sku}", // TODO : get the class and sku from backend modification
              "Class A | Sku : ABC-12345-S-BL",
              style: textTheme.titleSmall
                  ?.copyWith(color: colorTheme.onBackground),
            ),
          ],
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(CustomIcons.productImageTest),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                product?.name ?? '-',
                style: textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            // "Class ${widget.product.class_ ?? "null"} | Sku : ${widget.product.sku}", // TODO : get the class and sku from backend modification
            "Class A | Sku : ABC-12345-S-BL",
            style:
                textTheme.titleSmall?.copyWith(color: colorTheme.onBackground),
          ),
        ],
      );
    });
  }
}

class _ProductAppBar extends StatelessWidget {
  const _ProductAppBar({
    required this.productName,
  });

  final String? productName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SliverAppBar(
        pinned: true,
        floating: true,
        expandedHeight: size.height * 0.25,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          titlePadding: const EdgeInsetsDirectional.all(15),
          background: Image.asset(
            CustomIcons.productImageTest,
            fit: BoxFit.cover,
          ),
        ));
  }
}

class _TableRowProduct extends StatelessWidget {
  const _TableRowProduct({
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            maxLines: 1,
            softWrap: false,
            style: textTheme.titleSmall?.copyWith(color: colorTheme.secondary),
          ),
          Text(
            value,
            style: textTheme.titleSmall?.copyWith(color: colorTheme.secondary),
          ),
        ],
      ),
    );
  }
}
