import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_bloc.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_event.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_state.dart';
import 'package:savedge/features/coupons/presentation/pages/redeemed_coupon_page.dart';

class RedemptionHistoryPage extends StatelessWidget {
  const RedemptionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserCouponsBloc>()..add(const LoadUserCoupons()),
      child: const _RedemptionHistoryView(),
    );
  }
}

class _RedemptionHistoryView extends StatelessWidget {
  const _RedemptionHistoryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<UserCouponsBloc, UserCouponsState>(
        builder: (context, state) {
          return RefreshIndicator(
            color: const Color(0xFF6F3FCC),
            onRefresh: () async {
              context.read<UserCouponsBloc>().add(const LoadUserCoupons());
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                _buildAppBar(),
                if (state is UserCouponsLoading || state is UserCouponsInitial)
                  const SliverToBoxAdapter(child: _Skeleton())
                else if (state is UserCouponsLoaded)
                  ..._buildLoaded(context, state)
                else if (state is UserCouponsError)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _ErrorBody(
                      message: state.message,
                      onRetry: () => context
                          .read<UserCouponsBloc>()
                          .add(const LoadUserCoupons()),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 150,
      backgroundColor: Colors.transparent,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: Color(0xFF1A202C)),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          const expandedHeight = 150.0;
          final minHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;
          final t = ((constraints.maxHeight - minHeight) /
                  (expandedHeight - minHeight))
              .clamp(0.0, 1.0);
          final leftPadding = 20.0 + (52.0 * (1 - t));

          return Container(
            decoration: BoxDecoration(
              color: Color.lerp(Colors.white, Colors.transparent, t),
            ),
            child: Stack(
              children: [
                if (t > 0.05)
                  Positioned(
                    bottom: 52,
                    left: 20,
                    child: Opacity(
                      opacity: t.clamp(0.0, 1.0),
                      child: const Text(
                        'Your redeemed coupons',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                  ),
                FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                    left: leftPadding,
                    bottom: 16,
                    right: 20,
                  ),
                  centerTitle: false,
                  title: Text(
                    'History',
                    style: TextStyle(
                      color: const Color(0xFF1A202C),
                      fontSize: t > 0.5 ? 24 : 20,
                      fontWeight: t > 0.5 ? FontWeight.w800 : FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildLoaded(BuildContext context, UserCouponsLoaded state) {
    final redeemed = state.coupons.where((c) => c.isUsed).toList()
      ..sort((a, b) {
        final aDate = DateTime.tryParse(a.usedAt ?? '') ?? DateTime(2000);
        final bDate = DateTime.tryParse(b.usedAt ?? '') ?? DateTime(2000);
        return bDate.compareTo(aDate);
      });

    if (redeemed.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: _EmptyBody(onExplore: () => Navigator.pop(context)),
        ),
      ];
    }

    final totalSavings =
        redeemed.fold<double>(0, (s, c) => s + c.discountValue);

    // Group by month
    final grouped = <String, List<UserCouponModel>>{};
    for (final c in redeemed) {
      final date = DateTime.tryParse(c.usedAt ?? '');
      final key =
          date != null ? DateFormat('MMMM yyyy').format(date) : 'Unknown';
      grouped.putIfAbsent(key, () => []).add(c);
    }

    return [
      // Hero stats card
      SliverToBoxAdapter(
        child: _HeroStatsCard(
          totalRedeemed: redeemed.length,
          totalSavings: totalSavings,
        ),
      ),

      // Grouped list
      for (final entry in grouped.entries) ...[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
            child: Row(
              children: [
                Text(
                  entry.key.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: Color(0xFFB0B7C3),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child:
                      Container(height: 1, color: const Color(0xFFF0F0F0)),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${entry.value.length}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList.separated(
          itemCount: entry.value.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => _TicketCard(coupon: entry.value[i]),
        ),
      ],
    ];
  }
}

// ─── Hero Stats Card ────────────────────────────────────────

class _HeroStatsCard extends StatelessWidget {
  const _HeroStatsCard({
    required this.totalRedeemed,
    required this.totalSavings,
  });

  final int totalRedeemed;
  final double totalSavings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: AspectRatio(
        aspectRatio: 2.3,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFFCFBFF),
            border: Border.all(
              color: const Color(0xFF6F3FCC).withValues(alpha: 0.10),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6F3FCC).withValues(alpha: 0.08),
                offset: const Offset(0, 10),
                blurRadius: 28,
                spreadRadius: -6,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Aurora — top-left, emerald
              Positioned(
                left: -45,
                top: -50,
                child: _GlowOrb(
                  size: 170,
                  color: const Color(0xFF10B981),
                  opacity: 0.35,
                ),
              ),
              // Aurora — right, purple
              Positioned(
                right: -35,
                top: -25,
                child: _GlowOrb(
                  size: 190,
                  color: const Color(0xFF9F7AEA),
                  opacity: 0.30,
                ),
              ),
              // Aurora — bottom-center, amber
              Positioned(
                left: 70,
                bottom: -55,
                child: _GlowOrb(
                  size: 160,
                  color: const Color(0xFFF59E0B),
                  opacity: 0.22,
                ),
              ),
              // Aurora — bottom-right, blue
              Positioned(
                right: 15,
                bottom: -30,
                child: _GlowOrb(
                  size: 120,
                  color: const Color(0xFF3B82F6),
                  opacity: 0.20,
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Label
                    Text(
                      'Your savings so far',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color:
                            const Color(0xFF1A202C).withValues(alpha: 0.40),
                        letterSpacing: 0.2,
                      ),
                    ),
                    // Stats row
                    Row(
                      children: [
                        // Savings
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹${totalSavings.toInt()}',
                                style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1A202C),
                                  height: 1.0,
                                  letterSpacing: -1.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'total saved',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Vertical divider
                        Container(
                          width: 1,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          color: const Color(0xFF6F3FCC).withValues(alpha: 0.10),
                        ),
                        // Redeemed count
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6F3FCC)
                                    .withValues(alpha: 0.07),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                totalRedeemed.toString(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF6F3FCC),
                                  height: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'redeemed',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                          ],
                        ),
                      ],
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

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.size,
    required this.color,
    required this.opacity,
  });

  final double size;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: opacity),
              color.withValues(alpha: opacity * 0.25),
              color.withValues(alpha: 0),
            ],
            stops: const [0.0, 0.45, 1.0],
          ),
        ),
      ),
    );
  }
}

// ─── Ticket Card ────────────────────────────────────────────

class _TicketCard extends StatelessWidget {
  const _TicketCard({required this.coupon});

  final UserCouponModel coupon;

  static const _accents = [
    Color(0xFF6F3FCC),
    Color(0xFFFF6B6B),
    Color(0xFF10B981),
    Color(0xFF3B82F6),
    Color(0xFFEC407A),
    Color(0xFFF59E0B),
    Color(0xFF00BCD4),
    Color(0xFFAB47BC),
  ];

  Color get _accent => _accents[coupon.vendorId.abs() % _accents.length];

  @override
  Widget build(BuildContext context) {
    final accent = _accent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RedeemedCouponPage(userCoupon: coupon),
          ),
        ),
        child: PhysicalShape(
          clipper: const _TicketClipper(),
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.black.withValues(alpha: 0.08),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF0EEF5)),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  // Left stub — discount
                  SizedBox(
                    width: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.06),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _discountValue(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: accent,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _discountSuffix(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: accent.withValues(alpha: 0.7),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Dashed divider
                  SizedBox(
                    width: 1,
                    child: CustomPaint(
                      painter: _DashedDividerPainter(
                        color: const Color(0xFFE0E0E0),
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
                  // Right content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Vendor + date row
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  coupon.vendorName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1A202C),
                                  ),
                                ),
                              ),
                              Text(
                                _formatDate(coupon.usedAt),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFB0B7C3),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          // Title
                          Text(
                            coupon.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                          if (coupon.redemptionCode != null) ...[
                            const SizedBox(height: 10),
                            // Full code — tappable to copy
                            GestureDetector(
                              onTap: () =>
                                  _copyCode(context, coupon.redemptionCode!),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8F7FA),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFEEECF2),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        coupon.redemptionCode!,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'monospace',
                                          color: Color(0xFF1A202C),
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: accent.withValues(alpha: 0.08),
                                        borderRadius:
                                            BorderRadius.circular(6),
                                      ),
                                      child: Icon(
                                        Icons.copy_rounded,
                                        size: 13,
                                        color: accent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _discountValue() {
    if (coupon.discountType.toLowerCase() == 'percentage') {
      return '${coupon.discountValue.toInt()}%';
    }
    return '₹${coupon.discountValue.toInt()}';
  }

  String _discountSuffix() {
    return 'OFF';
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM').format(date);
    } catch (e) {
      return '';
    }
  }

  void _copyCode(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Code copied'),
        backgroundColor: const Color(0xFF1A202C),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

/// Clips the ticket with semicircle notches at the divider line (x ≈ 80).
class _TicketClipper extends CustomClipper<Path> {
  const _TicketClipper();

  static const double _notchRadius = 10.0;
  static const double _notchX = 80.0;
  static const double _cornerRadius = 16.0;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromLTRBR(
          0, 0, size.width, size.height,
          const Radius.circular(_cornerRadius),
        ),
      );

    final topNotch = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(_notchX, 0),
        radius: _notchRadius,
      ));

    final bottomNotch = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(_notchX, size.height),
        radius: _notchRadius,
      ));

    return Path.combine(
      PathOperation.difference,
      Path.combine(PathOperation.difference, path, topNotch),
      bottomNotch,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Dashed vertical line between notches.
class _DashedDividerPainter extends CustomPainter {
  const _DashedDividerPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const dash = 4.0;
    const gap = 4.0;
    double y = 12;
    while (y < size.height - 12) {
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, y + dash),
        paint,
      );
      y += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Empty State ────────────────────────────────────────────

class _EmptyBody extends StatelessWidget {
  const _EmptyBody({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withValues(alpha: 0.06),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF6F3FCC).withValues(alpha: 0.12),
              ),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              size: 44,
              color: Color(0xFF6F3FCC),
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'No redemptions yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Redeem your coupons at stores\nand they will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 28),
          ElevatedButton(
            onPressed: onExplore,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6F3FCC),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            child: const Text(
              'Browse coupons',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Error State ────────────────────────────────────────────

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wifi_off_rounded,
              size: 36,
              color: Color(0xFFEF4444),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text(
              'Try again',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF6F3FCC),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              side: const BorderSide(color: Color(0xFF6F3FCC)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Skeleton ───────────────────────────────────────────────

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          // Hero card skeleton
          Container(
            height: 130,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          const SizedBox(height: 24),
          // Ticket skeletons
          for (int i = 0; i < 5; i++) ...[
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
