import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/order/bloc/order_bloc.dart';
import 'package:hive_stock/order/models/order.dart';
import 'package:hive_stock/product/views/product_page.dart';
import 'package:hive_stock/utils/widgets/table_row.dart';

import 'details_card.dart';

class OrderBody extends StatelessWidget {
  final bool isFromScan;
  final ScrollController? scrollController;

  const OrderBody({
    super.key,
    required this.isFromScan,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // Size size = MediaQuery.of(context).size;
    // ColorScheme colorTheme = Theme.of(context).colorScheme;
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        Order? order = state.orderData;
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20)
                    .copyWith(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Order •",
                          style: textTheme.headlineLarge,
                        ),
                        Text(
                          order?.isEntry ?? true ? "Incoming" : "Outgoing",
                          style: textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    Text("order id : ${order?.id}"),
                    const SizedBox(height: 20),
                    informationSection(
                        context: context, title: "Order Overview"),
                    CustomTableRow(
                        title: "Status",
                        value: "${order?.commande?.statusString}"),
                    CustomTableRow(
                        title: "Prix total",
                        value: "${order?.commande?.prixTotal}"),
                    CustomTableRow(
                        title: "Date de la demande",
                        value: "${order?.commande?.dateCommande}"),
                    CustomTableRow(
                        title: "Lieu demandé",
                        value: "${order?.commande?.locationType}"),
                    CustomTableRow(
                        title: "Date de départ",
                        value: "${order?.commande?.dateDepart}"),
                    CustomTableRow(
                        title: "Date reçu",
                        value: "${order?.commande?.dateReelRecu}"),
                    const SizedBox(height: 20),
                    informationSection(
                        context: context, title: "Order Details"),
                  ],
                ),
              ),
            ),
            SliverList.builder(
              itemCount: order?.details?.length ?? 0,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: DetailsCard(
                    isFromScan: isFromScan,
                    onTap: () => _onProductTap(
                        context, order.details![index].productId!),
                    details: order!.details![index],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _onProductTap(BuildContext context, int productId) {
    Navigator.of(context).push(ProductPage.route(produitId: productId));
  }

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
}
