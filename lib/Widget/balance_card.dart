import 'package:budget_tracker/Theme/theme.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {

  final double balance;

  const BalanceCard({
    super.key,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: balance >= 0 ? Colors.green[100] : Colors.red[100],
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Balance",
              style: TextStyle(
                fontSize: AppSpacing.md,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              "\$${balance.toString()}",
              style: const TextStyle(
                fontSize: AppSpacing.lg,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}