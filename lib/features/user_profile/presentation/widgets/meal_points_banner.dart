import 'package:flutter/material.dart';

/// Compact banner surfacing the user's Meal Points balance, which lives in a
/// separate bucket from SavEdge points and can only be spent at participating
/// vendors. Callers should render it only when the balance is positive.
class MealPointsBanner extends StatelessWidget {
  const MealPointsBanner({super.key, required this.points, this.onTap});

  final int points;
  final VoidCallback? onTap;

  static const Color _accent = Color(0xFFEA580C);
  static const Color _background = Color(0xFFFFF7ED);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _background,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _accent.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.restaurant_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Meal Points',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$points points',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _accent,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Flexible(
                child: Text(
                  'At participating\nvendors',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 11, color: Colors.black45),
                ),
              ),
              if (onTap != null) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 12,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
