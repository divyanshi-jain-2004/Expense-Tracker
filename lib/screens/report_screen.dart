
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/transaction_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final categoryTotals = provider.calculateCategoryTotals();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Spending Report')),
      body:Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFa1c4fd), Color(0xFFc2e9fb)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: categoryTotals.isEmpty
                ? Center(
              child: Text(
                'No data available',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
                : PieChart(
              PieChartData(
                borderData: FlBorderData(show: false),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: categoryTotals.entries.map((entry) {
                  final percentage = (entry.value / provider.totalExpense) * 100;
                  return PieChartSectionData(
                    title: '${entry.key} \n${percentage.toStringAsFixed(1)}%',
                    radius: 100,
                    color: _getColor(entry.key),
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      )
    );
  }

  Color _getColor(String category) {
    switch (category) {
      case 'Food':
        return const Color(0xFFE57373);
      case 'Travel':
        return const Color(0xFF64B5F6);
      case 'Shopping':
        return const Color(0xFFBA68C8);
      case 'Bills':
        return const Color(0xFFFFB74D);
      default:
        return const Color(0xFF81C784);
    }
  }
}