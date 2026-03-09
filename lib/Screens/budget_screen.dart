import 'package:budget_tracker/Model/budget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budget_tracker/State/budget_notifier.dart';

class BudgetScreen  extends ConsumerWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(budgetProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Budget Tracker"),),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref.read(budgetProvider.notifier).addTransaction(
          Transaction(amount: 100, date: DateTime.now(), type: TransactionType.income)
        );
      },  child: const Icon(Icons.add),),
    body: Column(
    children: [
      Text("Balance: ${state.balance}", style: const TextStyle(fontSize: 24),),
    Expanded(child: ListView.builder(
    itemCount: state.transactions.length,
    itemBuilder: (context, index) {
      final transaction = state.transactions[index];

      return ListTile(
      title: Text(transaction.amount.toString()),
    subtitle: Text(transaction.type.name),
    trailing: IconButton(onPressed: () {
      ref.read(budgetProvider.notifier).removeTransaction(transaction);
    }, icon: const Icon(Icons.delete)),
      );
    },
    ))
    ],
    ),
    );
  }
}