import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/order/repository/order_repository.dart';
import 'package:hive_stock/order/views/order_page.dart';
import 'package:hive_stock/scanner/bloc/scanner_bloc.dart';
import 'package:hive_stock/scanner/models/scan_response.dart';
import 'package:hive_stock/scanner/views/scans_factory.dart';

class IncommingPage extends StatelessWidget {
  final ScrollController scrollController;
  final ScanResponse scanResponse;

  const IncommingPage(
      {super.key, required this.scrollController, required this.scanResponse});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => OrderRepository(),
      child: BlocProvider(
        create: (context) => ScannerBloc(
            orderRepository: RepositoryProvider.of<OrderRepository>(context))
          ..add(ScannerFectchEvent(response: scanResponse)),
        child: IncomingBody(scrollController: scrollController),
      ),
    );
  }
}

class IncomingBody extends StatelessWidget {
  final ScrollController scrollController;

  const IncomingBody({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerBloc, ScannerState>(
      builder: (context, state) {
        if (state.status == FetchOrderStatus.success) {
          return OrderPage(
            orderId: state.response!.id!,
            isFromScan: true,
            scrollController : scrollController,
          );
        }
        if (state.status == FetchOrderStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        ScanResultFactory factory = ScanResultFactory();
        Map<FetchOrderStatus, ResponseStatus> map = {
          FetchOrderStatus.done: ResponseStatus.success,
          FetchOrderStatus.inProgress: ResponseStatus.warning,
          FetchOrderStatus.orderWarning: ResponseStatus.warning,
          FetchOrderStatus.orderError: ResponseStatus.error,
        };
        return factory
            .createResponce(map[state.status]!, state.message)
            .showDetails(context, scrollController);
      },
    );
  }
}
