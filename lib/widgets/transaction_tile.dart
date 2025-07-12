import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel txn;
  const TransactionTile({super.key, required this.txn});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.attach_money_rounded, color: Colors.green),
        title: Text(
          txn.category,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(txn.notes),
        trailing: Text(
          '₹${txn.amount.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
