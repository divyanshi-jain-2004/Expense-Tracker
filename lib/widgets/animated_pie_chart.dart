import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/transaction_model.dart';

class AnimatedPieChart extends StatelessWidget {
  final List<TransactionModel> transactions;
  const AnimatedPieChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final categoryTotals = <String, double>{};
    for (var txn in transactions) {
      categoryTotals.update(txn.category, (value) => value + txn.amount,
          ifAbsent: () => txn.amount);
    }

    final total = categoryTotals.values.fold(0.0, (sum, item) => sum + item);

    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            centerSpaceRadius: 40,
            sectionsSpace: 3,
            sections: categoryTotals.entries.map((entry) {
              final percentage = entry.value / total;
              return PieChartSectionData(
                title: '${(percentage * 100).toStringAsFixed(1)}%',
                color: _getCategoryColor(entry.key),
                value: entry.value,
                radius: 100,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.teal;
      case 'Travel':
        return Colors.orange;
      case 'Shopping':
        return Colors.purple;
      case 'Bills':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
