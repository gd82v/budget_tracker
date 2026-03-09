import 'package:budget_tracker/Model/budget_model.dart';
import 'package:budget_tracker/State/budget_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BudgetNotifier  extends StateNotifier<BudgetState> {
  BudgetNotifier() : super(BudgetState(transactions: []));

  void addTransaction (Transaction transaction) {
    state = BudgetState(transactions: [...state.transactions, transaction]);
  }

  void removeTransaction (Transaction transaction) {
    state = BudgetState(transactions: state.transactions.where((t) => t != transaction).toList());
  }
}

final budgetProvider = StateNotifierProvider<BudgetNotifier, BudgetState>((ref) => BudgetNotifier());
