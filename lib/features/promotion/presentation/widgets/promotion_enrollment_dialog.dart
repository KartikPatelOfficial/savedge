import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/features/promotion/presentation/bloc/promotion_bloc.dart';

class PromotionEnrollmentDialog extends StatelessWidget {
  const PromotionEnrollmentDialog({super.key});

  static Future<void> show(BuildContext context) {
    final promotionBloc = context.read<PromotionBloc>();

    // Don't show if already enrolled
    final alreadyEnrolled = promotionBloc.state.maybeWhen(
      active: (status) => status.isEnrolled,
      orElse: () => false,
    );
    if (alreadyEnrolled) return Future.value();

    // Force a fresh check before showing
    promotionBloc.add(const PromotionEvent.checkStatus());

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => PopScope(
        canPop: false,
        child: BlocProvider.value(
          value: promotionBloc,
          child: const PromotionEnrollmentDialog(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PromotionBloc, PromotionState>(
      listener: (context, state) {
        state.whenOrNull(
          enrolled: (response) {
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                context.read<PromotionBloc>().add(const PromotionEvent.checkStatus());
                Navigator.of(context).pop();
              }
            });
          },
          active: (status) {
            // If user is already enrolled, dismiss immediately
            if (status.isEnrolled) {
              Navigator.of(context).pop();
            }
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message.replaceAll('Exception: ', '')),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),

                // Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8F65)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: state.maybeWhen(
                    enrolled: (_) => const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                    orElse: () => const Icon(
                      Icons.celebration_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  state.maybeWhen(
                    enrolled: (_) => 'You\'re In!',
                    orElse: () => 'Special Promotion!',
                  ),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  state.maybeWhen(
                    enrolled: (response) => response.message,
                    error: (message) =>
                        'For a limited time, get ALL coupons completely FREE! '
                        'No subscription or payment needed. Enroll now to unlock '
                        'unlimited free deals from all vendors.',
                    orElse: () =>
                        'For a limited time, get ALL coupons completely FREE! '
                        'No subscription or payment needed. Enroll now to unlock '
                        'unlimited free deals from all vendors.',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),

                // Action button
                state.maybeWhen(
                  enrolled: (_) => const SizedBox.shrink(),
                  enrolling: () => const SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF6B35),
                      ),
                    ),
                  ),
                  loading: () => const SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF6B35),
                      ),
                    ),
                  ),
                  orElse: () => SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<PromotionBloc>()
                            .add(const PromotionEvent.enroll());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B35),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Enroll Now - It\'s FREE!',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
