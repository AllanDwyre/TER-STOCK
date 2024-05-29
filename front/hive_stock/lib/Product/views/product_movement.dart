import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_stock/product/bloc/product_bloc.dart';
import 'package:hive_stock/utils/methods/logger.dart';

class Movement extends StatelessWidget {
  final ProductState state;
  const Movement({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    logger.d(state.barGroups?.length);
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Current Class ${state.product?.classe ?? "- "}',
          style: textTheme.titleMedium?.copyWith(color: colorTheme.secondary),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 1,
            child: BarChart(
              BarChartData(barGroups: state.barGroups),
            ),
          ),
        ),
      ],
    );
  }
}
