import 'package:flutter/foundation.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  final List<TransactionModel> _transactions = [];
  double _budget = 0.0;

  List<TransactionModel> get transactions => _transactions;

  double get totalExpense => _transactions.fold(0.0, (sum, item) => sum + item.amount);

  double get budget => _budget;

  void setBudget(double value) {
    _budget = value;
    notifyListeners();
  }

  void addTransaction(TransactionModel txn) {
    _transactions.add(txn);
    notifyListeners();
  }

  void deleteTransaction(int index) {
    _transactions.removeAt(index);
    notifyListeners();
  }

  void fetchTransactions() {
    // This can be extended to fetch from a local database or Firebase
    notifyListeners();
  }

  Map<String, double> calculateCategoryTotals() {
    final Map<String, double> categoryMap = {};
    for (var txn in _transactions) {
      categoryMap[txn.category] = (categoryMap[txn.category] ?? 0) + txn.amount;
    }
    return categoryMap;
  }
}
