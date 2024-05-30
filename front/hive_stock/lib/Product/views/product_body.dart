import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/product/bloc/product_bloc.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'package:hive_stock/utils/widgets/snackbars.dart';

import '../../utils/widgets/custom_tab_bar.dart';
import '../../utils/widgets/table_row.dart';
import 'product_movement.dart';

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
        Product? product = state.product;
        return CustomScrollView(
          controller: widget.scrollController,
          slivers: [
            SliverVisibility(
              visible: widget.isFullHeader,
              sliver: _ProductAppBar(
                productName: product?.name,
                productImg: product?.img,
              ),
            ),
            _ProductHeader(product: product, isFullHeader: widget.isFullHeader),
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              primary: false,
              title: CustomTabBar(
                tabController: tabController,
                onTap: (index) => onTabTap(context, index),
                tabs: const [
                  Tab(text: "Overview"),
                  Tab(text: "Movement"),
                  Tab(text: "Finance"),
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
                    Movement(state: state),
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

  onTabTap(BuildContext context, int index) {
    switch (index) {
      case 1:
        context.read<ProductBloc>().add(ProductFetchedMovement());
        break;
      default:
    }
  }
}

class _History extends StatelessWidget {
  const _History();

  @override
  Widget build(BuildContext context) {
    return const Text('data');
  }
}

class _Adjustement extends StatelessWidget {
  const _Adjustement();

  @override
  Widget build(BuildContext context) {
    return const Text('data');
  }
}

class _Overview extends StatelessWidget {
  const _Overview({this.product});

  final Product? product;

  Text informationSection(
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
      children: [
        informationSection(title: 'Primary Details', context: context),
        CustomTableRow(title: 'Name', value: checkValue(product?.name)),
        CustomTableRow(title: 'Product Sku', value: checkValue(product?.sku)),
        CustomTableRow(
            title: 'Product Barcode', value: checkValue(product?.barcode)),
        CustomTableRow(
            title: 'Product Class', value: checkValue(product?.dimensions)),
        CustomTableRow(
            title: 'Product Price',
            value: checkValue(product?.unitPrice.toString())),
        const CustomTableRow(title: 'Product category', value: 'Pharmacy'),
        const CustomTableRow(title: 'Storage date', value: '15/02/2023'),
        informationSection(title: 'Quantity Details', context: context),
        CustomTableRow(title: 'Quantity', value: "${product?.quantity}"),
        const CustomTableRow(title: 'At preparation', value: '50'),
        const CustomTableRow(title: 'On the way', value: '150'),
        const CustomTableRow(title: 'Arrival Date', value: '15/06/2023'),
        CustomTableRow(title: 'Threshold Value', value: "${product?.seuil}"),
        informationSection(title: 'Supplier Details', context: context),
        const CustomTableRow(title: 'Supplier Name', value: 'Phara LDC'),
        const CustomTableRow(
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
              visible: (product?.productId ?? 1) % 2 == 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Special handling",
                    style: textTheme.headlineMedium
                        ?.copyWith(color: colorTheme.onBackground),
                  ),
                  const SizedBox(height: 10),
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

    ImageProvider<Object>? imageProduct;
    try{
      imageProduct = MemoryImage(base64Decode(product!.img!.substring(1, product!.img!.length - 1)));
    } catch(e) { logger.t(e); }
    
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
              "Class ${product?.classe ?? "-"} | Sku : ${product?.sku ?? "-"}",
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
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProduct?? const AssetImage(CustomIcons.productImageTest),
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
            "Class ${product?.classe ?? "-"} | Sku : ${product?.sku ?? "-"}",
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
    this.productImg
  });

  final String? productName;
  final String? productImg;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Image? imageProduct;
    try{
      imageProduct = Image.memory(base64Decode(productImg!.substring(1, productImg!.length - 1)), fit:BoxFit.cover);
    } catch(e) { logger.t(e); }

    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: size.height * 0.25,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsetsDirectional.all(15),
        background: imageProduct?? Image.asset(
          CustomIcons.productImageTest,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
