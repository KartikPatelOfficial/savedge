import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/free_trial/data/models/free_trial_models.dart';
import 'package:savedge/features/free_trial/data/repositories/free_trial_repository.dart';
import 'package:savedge/features/free_trial/presentation/bloc/free_trial_bloc.dart';
import 'package:savedge/features/subscription/domain/entities/subscription_plan.dart';
import 'package:savedge/features/subscription/presentation/bloc/subscription_plan_bloc.dart';
import 'package:savedge/features/subscription/presentation/pages/subscription_purchase_page.dart';

class SubscriptionCarousel extends StatefulWidget {
  const SubscriptionCarousel({super.key});

  @override
  State<SubscriptionCarousel> createState() => _SubscriptionCarouselState();
}

class _SubscriptionCarouselState extends State<SubscriptionCarousel> {
  final PageController _pageController = PageController();
  bool _isLoading = true;
  bool _isVisible = false;

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();
  FreeTrialRepository get _freeTrialRepository => GetIt.I<FreeTrialRepository>();

  @override
  void initState() {
    super.initState();
    _checkVisibility();
    _pageController.addListener(() {
      if (_pageController.page == _pageController.page?.round()) {
        HapticFeedback.lightImpact();
      }
    });
  }

  Future<void> _checkVisibility() async {
    try {
      final profile = await _authRepository.getUserProfileExtended();

      final bool hasActiveSubscription = profile.hasActiveSubscription;

      // Show carousel if user doesn't have an active subscription
      // This will show either free trial offer (if available) or subscription plans
      final bool shouldBeVisible = !hasActiveSubscription;

      if (mounted) {
        setState(() {
          _isVisible = shouldBeVisible;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isVisible = true; // Show by default on error
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox.shrink();
    }

    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    return AspectRatio(
      aspectRatio: 4 / 5,
      child: PageView(
        controller: _pageController,
        children: [
          // Page 1: Free Trial Card
          BlocProvider.value(
            value: getIt<FreeTrialBloc>(),
            child: const _FreeTrialPage(),
          ),
          // Page 2: Subscription Plans
          BlocProvider.value(
            value: getIt<SubscriptionPlanBloc>(),
            child: const _SubscriptionPlansPage(),
          ),
        ],
      ),
    );
  }
}

class _FreeTrialPage extends StatelessWidget {
  const _FreeTrialPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FreeTrialBloc, FreeTrialState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (status) => _buildFreeTrialCard(context, status),
          activating: () => const Center(child: CircularProgressIndicator()),
          activated: (response) {
            Future.delayed(const Duration(seconds: 2), () {
              context.read<FreeTrialBloc>().add(const FreeTrialEvent.loadStatus());
            });
            return _SuccessCard(message: response.message);
          },
          error: (message) => _ErrorCard(message: message),
        );
      },
    );
  }

  Widget _buildFreeTrialCard(BuildContext context, FreeTrialStatusResponse status) {
    if (status.status == FreeTrialStatus.notStarted && status.canActivate) {
      return _OfferCard(
        onActivate: () {
          context.read<FreeTrialBloc>().add(const FreeTrialEvent.activateTrial());
        },
      );
    }

    if (status.status == FreeTrialStatus.active && status.remainingTime != null) {
      return _CountdownCard(remainingTime: status.remainingTime!);
    }

    return const SizedBox.shrink();
  }
}

class _SubscriptionPlansPage extends StatelessWidget {
  const _SubscriptionPlansPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionPlanBloc, SubscriptionPlanState>(
      builder: (context, state) {
        if (state is SubscriptionPlanLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SubscriptionPlanLoaded) {
          if (state.plans.isEmpty) {
            return const Center(child: Text('No subscription plans available.'));
          }
          return _buildPlansWidget(context, state.plans);
        } else if (state is SubscriptionPlanError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildPlansWidget(BuildContext context, List<SubscriptionPlan> plans) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Subscription Plans',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A202C),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: plans.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: index < plans.length - 1 ? 12 : 0),
                child: SizedBox(
                  width: 280,
                  child: _SubscriptionPlanCard(
                    plan: plans[index],
                    onTap: (plan) => _navigateToDetails(context, plan),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _navigateToDetails(BuildContext context, SubscriptionPlan plan) {
    Navigator.of(context).push(SubscriptionPurchasePage.route(plan));
  }
}

// Re-using cards from free_trial_card.dart
class _OfferCard extends StatelessWidget {
  final VoidCallback onActivate;
  const _OfferCard({required this.onActivate});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade400, Colors.deepPurple.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow.shade300, size: 32),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Start Your Free Trial!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Get 5 days of premium membership access for FREE!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Access all exclusive coupons\n• No credit card required\n• Cancel anytime',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onActivate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Activate Free Trial',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CountdownCard extends StatelessWidget {
  final RemainingTimeResponse remainingTime;
  const _CountdownCard({required this.remainingTime});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade400, Colors.cyan.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.timer, color: Colors.white, size: 28),
                const SizedBox(width: 8),
                const Text(
                  'Free Trial Active',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _TimeUnit(
                  value: remainingTime.days,
                  label: 'Days',
                ),
                _TimeUnit(
                  value: remainingTime.hours,
                  label: 'Hours',
                ),
                _TimeUnit(
                  value: remainingTime.minutes,
                  label: 'Minutes',
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Enjoy premium membership access!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeUnit extends StatelessWidget {
  final int value;
  final String label;
  const _TimeUnit({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _SuccessCard extends StatelessWidget {
  final String message;
  const _SuccessCard({required this.message});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  const _ErrorCard({required this.message});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            const Icon(Icons.error, color: Colors.red, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _SubscriptionPlanCard extends StatelessWidget {
  const _SubscriptionPlanCard({required this.plan, this.onTap});

  final SubscriptionPlan plan;
  final Function(SubscriptionPlan)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(plan),
      child: Container(
        constraints: BoxConstraints(
          minWidth: 280,
          maxWidth: MediaQuery.of(context).size.width - 40,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: plan.hasImage ? _buildImageCard() : _buildFallbackCard(),
        ),
      ),
    );
  }

  Widget _buildImageCard() {
    return Image.network(
      plan.imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildFallbackCard();
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 200, // Minimum height for loading indicator
          color: Colors.grey[200],
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildFallbackCard() {
    return Builder(
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow[600], size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    plan.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              plan.priceDisplay,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              plan.durationDisplay,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
