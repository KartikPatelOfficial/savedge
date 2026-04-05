import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/free_trial/data/models/free_trial_models.dart';
import 'package:savedge/features/free_trial/presentation/bloc/free_trial_bloc.dart';
import 'package:savedge/features/promotion/presentation/bloc/promotion_bloc.dart';
import 'package:savedge/features/subscription/domain/entities/subscription_plan.dart';
import 'package:savedge/features/subscription/presentation/bloc/subscription_plan_bloc.dart';
import 'package:savedge/features/subscription/presentation/pages/subscription_purchase_page.dart';

class SubscriptionCarousel extends StatefulWidget {
  const SubscriptionCarousel({super.key, this.isGuest = false});

  final bool isGuest;

  @override
  State<SubscriptionCarousel> createState() => _SubscriptionCarouselState();
}

class _SubscriptionCarouselState extends State<SubscriptionCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _isLoading = true;
  bool _isVisible = false;

  // Auto-scroll fields
  Timer? _autoScrollTimer;
  bool _isUserInteracting = false;
  int _totalCards = 0;

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
    // Guest users always see the plans carousel
    if (widget.isGuest) {
      if (mounted) {
        setState(() {
          _isVisible = true;
          _isLoading = false;
        });
      }
      return;
    }

    try {
      // Check if user has active promotion enrollment - hide carousel if so
      final promotionBloc = getIt<PromotionBloc>();
      final promotionState = promotionBloc.state;
      final hasActivePromotion = promotionState.maybeWhen(
        active: (status) => status.isEnrolled,
        orElse: () => false,
      );

      if (hasActivePromotion) {
        if (mounted) {
          setState(() {
            _isVisible = false;
            _isLoading = false;
          });
        }
        return;
      }

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
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // Auto-scroll methods
  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (_totalCards <= 1) return;
    _autoScrollTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _scrollToNextPage(),
    );
  }

  void _scrollToNextPage() {
    if (_isUserInteracting || !mounted || _totalCards <= 1) return;
    final nextPage = (_currentPage + 1) % _totalCards;
    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _pauseAutoScroll() {
    _isUserInteracting = true;
    _autoScrollTimer?.cancel();
  }

  void _resumeAutoScroll() {
    _isUserInteracting = false;
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && !_isUserInteracting) {
        _startAutoScroll();
      }
    });
  }

  void _updateTotalCards(int count) {
    if (_totalCards != count) {
      _totalCards = count;
      if (_totalCards > 1 && !_isUserInteracting) {
        _startAutoScroll();
      }
    }
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
        onPauseAutoScroll: _pauseAutoScroll,
        onResumeAutoScroll: _resumeAutoScroll,
        onCardsCountChanged: _updateTotalCards,
      ),
    );
  }
}

class _UnifiedCarousel extends StatelessWidget {
  const _UnifiedCarousel({
    required this.pageController,
    required this.currentPage,
    required this.onPauseAutoScroll,
    required this.onResumeAutoScroll,
    required this.onCardsCountChanged,
  });

  final PageController pageController;
  final int currentPage;
  final VoidCallback onPauseAutoScroll;
  final VoidCallback onResumeAutoScroll;
  final ValueChanged<int> onCardsCountChanged;

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

            // Notify about cards count for auto-scroll
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onCardsCountChanged(cards.length);
            });

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
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollStartNotification) {
                          onPauseAutoScroll();
                        } else if (notification is ScrollEndNotification) {
                          onResumeAutoScroll();
                        }
                        return false;
                      },
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
              trialDays: status.trialDurationDays,
              imageUrl: status.freeTrialImageUrl,
              onActivate: () {
                context.read<FreeTrialBloc>().add(
                  const FreeTrialEvent.activateTrial(),
                );
              },
            ),
          );
        } else if (status.status == FreeTrialStatus.active &&
            status.remainingTime != null) {
          cards.add(_CountdownCard(
            remainingTime: status.remainingTime!,
            trialDays: status.trialDurationDays,
          ));
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

// ─────────────────────────────────────────────────────────────────────────────
// FREE TRIAL OFFER CARD (Not Started)
// ─────────────────────────────────────────────────────────────────────────────

class _OfferCard extends StatefulWidget {
  final int trialDays;
  final String? imageUrl;
  final VoidCallback onActivate;

  const _OfferCard({required this.trialDays, this.imageUrl, required this.onActivate});

  @override
  State<_OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<_OfferCard> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return _buildImageCard();
    }
    return _buildDefaultCard();
  }

  Widget _buildImageCard() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onActivate();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.network(
          widget.imageUrl!,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(0xFFF3F0FF),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: const Color(0xFF6F3FCC),
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultCard();
          },
        ),
      ),
    );
  }

  Widget _buildDefaultCard() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onActivate();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF7C3AED), // vivid purple
              Color(0xFF6F3FCC), // primary purple
              Color(0xFF5B21B6), // deep purple
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6F3FCC).withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Background decorative circles
              Positioned(
                top: -40,
                right: -40,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.08),
                  ),
                ),
              ),
              Positioned(
                bottom: -60,
                left: -30,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
              ),

              // Main content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),

                    // FREE badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome, color: Colors.amber.shade300, size: 16),
                          const SizedBox(width: 6),
                          const Text(
                            'LIMITED TIME OFFER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 2),

                    // Days number - big and bold
                    Text(
                      '${widget.trialDays}',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'DAYS',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white70,
                        letterSpacing: 6,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // FREE text with shimmer
                    AnimatedBuilder(
                      animation: _shimmerController,
                      builder: (context, child) {
                        return ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              colors: const [
                                Color(0xFFFDE68A),
                                Colors.white,
                                Color(0xFFFDE68A),
                              ],
                              stops: [
                                _shimmerController.value - 0.3,
                                _shimmerController.value,
                                _shimmerController.value + 0.3,
                              ].map((s) => s.clamp(0.0, 1.0)).toList(),
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds);
                          },
                          child: const Text(
                            'FREE',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 4,
                            ),
                          ),
                        );
                      },
                    ),

                    const Text(
                      'Trial Membership',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),

                    const Spacer(flex: 2),

                    // Features row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _FeatureChip(icon: Icons.local_offer_outlined, label: 'All Coupons'),
                        _FeatureChip(icon: Icons.store_outlined, label: 'All Vendors'),
                        _FeatureChip(icon: Icons.workspace_premium_outlined, label: 'Premium'),
                      ],
                    ),

                    const Spacer(),

                    // CTA Button
                    Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFF59E0B).withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Start Free Trial',
                              style: TextStyle(
                                color: Color(0xFF1A202C),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded, color: Color(0xFF1A202C), size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'No payment required',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FREE TRIAL COUNTDOWN CARD (Active)
// ─────────────────────────────────────────────────────────────────────────────

class _CountdownCard extends StatefulWidget {
  final RemainingTimeResponse remainingTime;
  final int trialDays;

  const _CountdownCard({required this.remainingTime, required this.trialDays});

  @override
  State<_CountdownCard> createState() => _CountdownCardState();
}

class _CountdownCardState extends State<_CountdownCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  double get _progress {
    final totalSeconds = widget.trialDays * 24 * 60 * 60;
    if (totalSeconds == 0) return 0;
    return (widget.remainingTime.totalSeconds / totalSeconds).clamp(0.0, 1.0);
  }

  bool get _isUrgent => widget.remainingTime.days <= 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isUrgent
              ? [const Color(0xFFDC2626), const Color(0xFFEF4444), const Color(0xFFF87171)]
              : [const Color(0xFF6F3FCC), const Color(0xFF7C3AED), const Color(0xFF9F7AEA)],
        ),
        boxShadow: [
          BoxShadow(
            color: (_isUrgent ? const Color(0xFFDC2626) : const Color(0xFF6F3FCC))
                .withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background decorative elements
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.07),
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -20,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Header
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1.0 + (_pulseController.value * 0.1),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                _isUrgent ? Icons.warning_rounded : Icons.verified_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isUrgent ? 'Trial Ending Soon!' : 'Free Trial Active',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${widget.trialDays}-day membership',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Live badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: _isUrgent
                              ? Colors.white.withOpacity(0.25)
                              : const Color(0xFF38A169).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(
                                      0.6 + (_pulseController.value * 0.4),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _isUrgent ? 'EXPIRING' : 'ACTIVE',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Spacer(flex: 2),

                  // Countdown timer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _TimeUnit(
                        value: widget.remainingTime.days,
                        label: 'Days',
                        isUrgent: _isUrgent,
                      ),
                      _TimeSeparator(isUrgent: _isUrgent),
                      _TimeUnit(
                        value: widget.remainingTime.hours,
                        label: 'Hours',
                        isUrgent: _isUrgent,
                      ),
                      _TimeSeparator(isUrgent: _isUrgent),
                      _TimeUnit(
                        value: widget.remainingTime.minutes,
                        label: 'Mins',
                        isUrgent: _isUrgent,
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Progress bar
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time remaining',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '${(_progress * 100).toInt()}%',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: _progress,
                          minHeight: 8,
                          backgroundColor: Colors.white.withOpacity(0.15),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _isUrgent
                                ? const Color(0xFFFBBF24)
                                : Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Bottom info section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.workspace_premium_rounded,
                          color: Colors.amber.shade300,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Enjoy premium membership access!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white.withOpacity(0.5),
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
  final bool isUrgent;

  const _TimeUnit({
    required this.value,
    required this.label,
    this.isUrgent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isUrgent ? const Color(0xFFFBBF24) : Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _TimeSeparator extends StatelessWidget {
  final bool isUrgent;

  const _TimeSeparator({this.isUrgent = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, left: 6, right: 6),
      child: Text(
        ':',
        style: TextStyle(
          color: isUrgent ? const Color(0xFFFBBF24) : Colors.white.withOpacity(0.6),
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SUCCESS CARD (Just Activated)
// ─────────────────────────────────────────────────────────────────────────────

class _SuccessCard extends StatelessWidget {
  final String message;

  const _SuccessCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF059669), Color(0xFF10B981), Color(0xFF34D399)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF059669).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.celebration_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Trial Activated!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SUBSCRIPTION PLAN CARD
// ─────────────────────────────────────────────────────────────────────────────

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
          height: 200,
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
