class TransactionModel {
  final int? id;
  final String category;
  final double amount;
  final String notes;
  final DateTime date;

  TransactionModel({
    this.id,
    required this.category,
    required this.amount,
    required this.notes,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'notes': notes,
      'date': date.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      category: map['category'],
      amount: map['amount'],
      notes: map['notes'],
      date: DateTime.parse(map['date']),
    );
  }
}
