enum TransactionType { income, expense }

class Transaction {
  final double amount;
  final DateTime date;
  final String? comment;
  final TransactionType type;

  Transaction({
    required this.amount,
    required this.date,
    this.comment,
    required this.type
});
}