import 'package:budget_tracker/Model/budget_model.dart';
import 'package:budget_tracker/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../State/budget_notifier.dart';

class AddTransactionSheet extends ConsumerStatefulWidget {
  const AddTransactionSheet({super.key});

  @override
  ConsumerState<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends ConsumerState<AddTransactionSheet> {
  final amountController = TextEditingController();
  final commentController = TextEditingController();
  DateTime selectDate = DateTime.now();
  TransactionType type = TransactionType.income;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
    child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Add transaction", style: TextStyle(fontSize: 20),),
        const SizedBox(height: AppSpacing.md,),
        TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Amount"
          ),
        ),
        const SizedBox(height: AppSpacing.md,),
        TextField(
          controller: commentController,
          decoration: const InputDecoration(
            labelText: "Comment"
          ),
        ),
        const SizedBox(height: AppSpacing.md,),
        TextButton(onPressed: () async {
          final picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
          initialDate: selectDate);
          if (picked != null) {
            setState(() {
              selectDate = picked;
            });
          }
        }, child: Text("Date: ${selectDate.toLocal()}")),
        const SizedBox(height: AppSpacing.md),
        DropdownButton<TransactionType>(
            value: type,
            items: TransactionType.values.map((t) {
              return DropdownMenuItem(
                value: t,
                child: Text(t.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                type = value!;
              });
            }),
        const SizedBox(height: AppSpacing.md),
        ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text);
              if (amount == null) return;

              ref.read(budgetProvider.notifier).addTransaction(Transaction(
                  amount: amount,
                  date: selectDate,
                  comment: commentController.text,
                  type: type
              ));
              Navigator.pop(context);
            }, child: const Text("Add"))
      ],
    ),),);
  }
}