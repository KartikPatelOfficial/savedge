import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/features/promotion/data/models/promotion_models.dart';
import 'package:savedge/features/promotion/presentation/bloc/promotion_bloc.dart';

class PromotionBanner extends StatelessWidget {
  const PromotionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionBloc, PromotionState>(
      builder: (context, state) {
        return state.maybeWhen(
          active: (status) {
            if (!status.isEnrolled) return const SizedBox.shrink();
            return _buildBanner(status);
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildBanner(PromotionStatusResponse status) {
    final expiresAt = status.promotionExpiresAt;
    final daysLeft = expiresAt != null
        ? expiresAt.difference(DateTime.now()).inDays
        : 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8F65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.celebration_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'All Coupons are FREE!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  daysLeft > 0
                      ? 'Promotion ends in $daysLeft days'
                      : 'Promotion ends today',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.85),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
