import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  final String amount;
  final String type;
  final String? comment;
  final DateTime date;
  final VoidCallback onDelete;

  const TransactionItem({
    super.key,
    required this.amount,
    required this.type,
    this.comment,
    required this.date,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(amount),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatDate(date)),
            if (comment != null && comment!.isNotEmpty) Text(comment!,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),),
          ],
        ),

        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}