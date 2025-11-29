import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/free_trial/data/models/free_trial_models.dart';
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
  late PageController _pageController;
  int _currentPage = 0;
  bool _isLoading = true;
  bool _isVisible = false;

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    _checkVisibility();
    _pageController.addListener(() {
      if (_pageController.page == _pageController.page?.round()) {
        HapticFeedback.lightImpact();
        final newPage = _pageController.page?.round() ?? 0;
        if (newPage != _currentPage) {
          setState(() {
            _currentPage = newPage;
          });
        }
      }
    });
  }

  Future<void> _checkVisibility() async {
    try {
      final profile = await _authRepository.getUserProfileExtended();
      final bool hasActiveSubscription = profile.hasActiveSubscription;
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
          _isVisible = true;
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

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<FreeTrialBloc>()),
        BlocProvider.value(value: getIt<SubscriptionPlanBloc>()),
      ],
      child: _UnifiedCarousel(
        pageController: _pageController,
        currentPage: _currentPage,
      ),
    );
  }
}

class _UnifiedCarousel extends StatelessWidget {
  const _UnifiedCarousel({
    required this.pageController,
    required this.currentPage,
  });

  final PageController pageController;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FreeTrialBloc, FreeTrialState>(
      builder: (context, freeTrialState) {
        return BlocBuilder<SubscriptionPlanBloc, SubscriptionPlanState>(
          builder: (context, subscriptionState) {
            final cards = _buildCards(
              context,
              freeTrialState,
              subscriptionState,
            );

            if (cards.isEmpty) {
              return const SizedBox.shrink();
            }

            // Calculate height based on screen width and aspect ratio
            final screenWidth = MediaQuery.of(context).size.width;
            final cardWidth = screenWidth * 0.9;
            final cardHeight = cardWidth * (5 / 4); // 4:5 aspect ratio
            final headerHeight = 60.0;
            final dotsHeight = cards.length > 1 ? 24.0 : 0.0;
            final totalHeight = headerHeight + dotsHeight + cardHeight;

            return SizedBox(
              height: totalHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: Text(
                      'Our Plans',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                  ),

                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: AspectRatio(
                            aspectRatio: 4 / 5,
                            child: cards[index],
                          ),
                        );
                      },
                    ),
                  ),
                  if (cards.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          cards.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage == index
                                  ? const Color(0xFF1A202C)
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildCards(
    BuildContext context,
    FreeTrialState freeTrialState,
    SubscriptionPlanState subscriptionState,
  ) {
    final List<Widget> cards = [];

    // Add free trial card if eligible
    freeTrialState.whenOrNull(
      loaded: (status) {
        if (status.status == FreeTrialStatus.notStarted && status.canActivate) {
          cards.add(
            _OfferCard(
              onActivate: () {
                context.read<FreeTrialBloc>().add(
                  const FreeTrialEvent.activateTrial(),
                );
              },
            ),
          );
        } else if (status.status == FreeTrialStatus.active &&
            status.remainingTime != null) {
          cards.add(_CountdownCard(remainingTime: status.remainingTime!));
        }
      },
      activated: (response) {
        cards.add(_SuccessCard(message: response.message));
      },
    );

    // Add subscription plan cards
    if (subscriptionState is SubscriptionPlanLoaded) {
      for (var plan in subscriptionState.plans) {
        cards.add(
          _SubscriptionPlanCard(
            plan: plan,
            onTap: (plan) => _navigateToDetails(context, plan),
          ),
        );
      }
    }

    return cards;
  }

  void _navigateToDetails(BuildContext context, SubscriptionPlan plan) {
    Navigator.of(context).push(SubscriptionPurchasePage.route(plan));
  }
}

class _OfferCard extends StatelessWidget {
  final VoidCallback onActivate;

  const _OfferCard({required this.onActivate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onActivate,
      child: Card(
        margin: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Image.asset('assets/images/free_trial.png', fit: BoxFit.cover),
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
                _TimeUnit(value: remainingTime.days, label: 'Days'),
                _TimeUnit(value: remainingTime.hours, label: 'Hours'),
                _TimeUnit(value: remainingTime.minutes, label: 'Minutes'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Enjoy premium membership access!',
              style: TextStyle(color: Colors.white, fontSize: 14),
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
          style: const TextStyle(color: Colors.white70, fontSize: 14),
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
              child: Text(message, style: const TextStyle(fontSize: 16)),
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
