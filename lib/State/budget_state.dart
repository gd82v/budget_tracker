import 'package:budget_tracker/Model/budget_model.dart';

class BudgetState {
  final List<Transaction> transactions;

  BudgetState({
    required this.transactions
});

  double get balance {
    return transactions.fold(0, (sum, transaction) {
      if (transaction.type == TransactionType.income) {
        return sum + transaction.amount;
      } else {
        return sum - transaction.amount;
      }
    });
  }

  BudgetState copyWith ({List<Transaction>? transactions}) {
    return BudgetState(transactions:  transactions ?? this.transactions);
  }
}