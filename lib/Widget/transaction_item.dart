import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {

  final String amount;
  final String type;
  final VoidCallback onDelete;

  const TransactionItem({
    super.key,
    required this.amount,
    required this.type,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(amount),
        subtitle: Text(type),

        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}