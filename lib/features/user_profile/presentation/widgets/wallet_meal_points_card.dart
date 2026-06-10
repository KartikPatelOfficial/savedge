import 'package:flutter/material.dart';

import 'package:savedge/features/user_profile/presentation/theme/wallet_tokens.dart';

/// Compact amber card surfacing the Meal Points bucket, which is kept
/// separate from SavEdge points. Only rendered when the user has any.
class WalletMealPointsCard extends StatelessWidget {
  const WalletMealPointsCard({super.key, required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(WalletTokens.s4),
      decoration: BoxDecoration(
        color: WalletTokens.mealSoft,
        borderRadius: BorderRadius.circular(WalletTokens.rCard),
        border: Border.all(color: WalletTokens.mealBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: WalletTokens.meal,
              borderRadius: BorderRadius.circular(WalletTokens.rTile),
            ),
            child: const Icon(
              Icons.restaurant_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: WalletTokens.s4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Meal points',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: WalletTokens.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${WalletTokens.fmt(points)} pts',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: WalletTokens.meal,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: WalletTokens.s3),
          const Text(
            'At participating\nvendors',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 11,
              height: 1.4,
              color: WalletTokens.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
