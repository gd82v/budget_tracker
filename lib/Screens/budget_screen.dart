import 'package:budget_tracker/Widget/add_transaction_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budget_tracker/State/budget_notifier.dart';
import '../Widget/balance_card.dart';
import '../Widget/transaction_item.dart';
import '../Theme/theme.dart';
import '../Model/budget_model.dart';

class BudgetScreen  extends ConsumerWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(budgetProvider);

    Widget buildTransactionList(state) {
      return Container(
        color: AppColors.background,
      child: Stack(
        children: [
        ListView.builder(itemCount: state.transactions.length,
            itemBuilder: (context, index){
          final transaction = state.transactions[index];
          return TransactionItem(
            amount: transaction.amount.toString(),
            type: transaction.type == TransactionType.income ? "Income" : "Expense",
            comment: transaction.comment,
            date: transaction.date,
            onDelete: () {
              ref.read(budgetProvider.notifier).removeTransaction(transaction);
              final messenger = ScaffoldMessenger.of(context);
              messenger.hideCurrentSnackBar();
              messenger.showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
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
        Center(
          child: AnimatedOpacity(
            opacity: state.transactions.isEmpty ? 1 : 0,
            duration: const Duration(seconds:3),
        child: const Text('''No transactions yet
        Tap + to add your first transaction''',
        style:TextStyle(fontSize: AppSpacing.md, color: AppColors.primary),),),)
      ],));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Budget Tracker"),),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add transaction",
          onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return AddTransactionSheet();
            });
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