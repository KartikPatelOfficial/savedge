import 'package:flutter/material.dart';

class BillSummaryCard extends StatelessWidget {
  const BillSummaryCard({
    super.key,
    required this.billAmount,
    required this.pointsUsed,
    required this.remainingAmount,
  });

  final double billAmount;
  final int pointsUsed;
  final double remainingAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.receipt_long,
                  color: Color(0xFF6F3FCC),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Bill Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSummaryRow(
            'Bill Amount',
            '₹${billAmount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF4A5568),
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Points Used',
            '-₹${pointsUsed.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF38A169),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.grey[200],
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(
            'Amount to Pay',
            '₹${remainingAmount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A202C),
            ),
          ),
          if (remainingAmount > 0) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFD69E2E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFFD69E2E),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Remaining amount to be paid at store',
                      style: TextStyle(
                        fontSize: 13,
                        color: const Color(0xFFD69E2E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {TextStyle? style}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: style ?? const TextStyle(
            fontSize: 16,
            color: Color(0xFF4A5568),
          ),
        ),
        Text(
          value,
          style: style ?? const TextStyle(
            fontSize: 16,
            color: Color(0xFF4A5568),
          ),
        ),
      ],
    );
  }
}