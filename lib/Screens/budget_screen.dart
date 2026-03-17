import 'package:budget_tracker/Model/budget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budget_tracker/State/budget_notifier.dart';
import '../Widget/balance_card.dart';
import '../Widget/transaction_item.dart';
import '../Theme/theme.dart';

class BudgetScreen  extends ConsumerWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(budgetProvider);

    Widget buildTransactionList(state) {
      return Stack(children: [
        ListView.builder(itemCount: state.transactions.length,
            itemBuilder: (context, index){
          final transaction = state.transactions[index];
          return TransactionItem(
            amount: transaction.amount.toString(),
            type: transaction.type.toString(),
            onDelete: () {
              ref.read(budgetProvider.notifier).removeTransaction(transaction);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Transaction deleted"),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      ref.read(budgetProvider.notifier)
                          .addTransaction(transaction);
                    },
                  ),),
              );},
          );
            }),
        Center(child: AnimatedOpacity(
            opacity: state.transactions.isEmpty ? 1 : 0,
            duration: const Duration(milliseconds:300),
        child: const Text('''No transactions yet
        Tap + to add your first transaction''',
        style:TextStyle(fontSize: AppSpacing.md, color: AppColors.primary),),),)
      ],);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Budget Tracker"),),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref.read(budgetProvider.notifier).addTransaction(
          Transaction(amount: 100, date: DateTime.now(), type: TransactionType.income)
        );
      },  child: const Icon(Icons.add),),
    body: LayoutBuilder(builder: (context, constraints){
      if (constraints.maxWidth > 600){
        return Row(
          children: [
            Expanded(child: BalanceCard(balance: state.balance)),
            Expanded(child: buildTransactionList(state))
          ],
        );
      } else {
        return Column(
          children: [
            BalanceCard(balance: state.balance),
            Expanded(child: buildTransactionList(state))
          ],
        );
      }
    })
    );
  }
}