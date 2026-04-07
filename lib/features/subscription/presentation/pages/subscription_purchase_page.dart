import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/auth/domain/entities/extended_user_profile.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/subscription/data/services/razorpay_payment_service.dart';
import 'package:savedge/features/subscription/domain/entities/subscription_plan.dart';

enum PaymentMethod {
  points('Pay with Points'),
  online('Pay Online');
  const PaymentMethod(this.displayName);
  final String displayName;
}

class SubscriptionPurchasePage extends StatefulWidget {
  const SubscriptionPurchasePage({super.key, required this.plan});
  final SubscriptionPlan plan;

  static Route<void> route(SubscriptionPlan plan) =>
      MaterialPageRoute(builder: (_) => SubscriptionPurchasePage(plan: plan));

  @override
  State<SubscriptionPurchasePage> createState() => _State();
}

class _State extends State<SubscriptionPurchasePage> {
  ExtendedUserProfile? _profile;
  bool _loading = true, _paying = false;
  String? _error;
  PaymentMethod _method = PaymentMethod.online;

  // ── palette ──
  static const _purple = Color(0xFF6F3FCC);
  static const _lilac = Color(0xFFEDE9FE);
  static const _mint = Color(0xFFD1FAE5);
  static const _mintDark = Color(0xFF059669);
  static const _peach = Color(0xFFFFF7ED);
  static const _peachDark = Color(0xFFEA580C);
  static const _bg = Color(0xFFF8F7FC);
  static const _card = Colors.white;
  static const _dark = Color(0xFF111827);
  static const _grey = Color(0xFF6B7280);
  static const _border = Color(0xFFF0EDF6);
  static const _radius = 20.0;

  AuthRepository get _auth => GetIt.I<AuthRepository>();
  RazorpayPaymentService get _pay => GetIt.I<RazorpayPaymentService>();
  SubscriptionPlan get plan => widget.plan;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _pay.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final p = await _auth.getUserProfileExtended();
      if (!mounted) return;
      setState(() {
        _profile = p;
        if (p.isEmployee && p.pointsBalance >= _pointsCost) {
          _method = PaymentMethod.points;
        }
        _loading = false;
      });
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _loading = false; });
    }
  }

  int get _pointsCost => plan.price.round();

  List<String> get _feats => (plan.features ?? '')
      .split('\n')
      .map((f) => f.trim())
      .where((f) => f.isNotEmpty)
      .toList();

  // ── build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: _loading
            ? const Center(child: CircularProgressIndicator(color: _purple, strokeWidth: 2.5))
            : _error != null
                ? _buildError()
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 8,
                            left: 16, right: 16, bottom: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _topBar(),
                              const SizedBox(height: 20),
                              if (plan.hasImage) ...[
                                _planImageCard(),
                                const SizedBox(height: 12),
                              ],
                              _bentoGrid(),
                              const SizedBox(height: 12),
                              if (_feats.isNotEmpty) ...[
                                _featuresBento(),
                                const SizedBox(height: 12),
                              ],
                              if (_profile?.isEmployee == true) ...[
                                _pointsBento(),
                                const SizedBox(height: 12),
                              ],
                              _paymentBento(),
                              const SizedBox(height: 16),
                              _trustSignals(),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      _bottomBar(),
                    ],
                  ),
      ),
    );
  }

  // ── top bar ────────────────────────────────────────────────────────────

  Widget _topBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _border),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: _dark),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: _lilac,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_rounded, size: 14, color: _purple),
              SizedBox(width: 5),
              Text('SECURE CHECKOUT',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: _purple, letterSpacing: 1)),
            ],
          ),
        ),
      ],
    );
  }

  // ── hero section ───────────────────────────────────────────────────────

  Widget _planImageCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: CachedNetworkImage(
        imageUrl: plan.imageUrl!,
        width: double.infinity,
        fit: BoxFit.fitWidth,
        placeholder: (_, __) => Container(
          height: 220,
          decoration: BoxDecoration(
            color: _lilac,
            borderRadius: BorderRadius.circular(_radius),
          ),
          child: const Center(child: CircularProgressIndicator(color: _purple, strokeWidth: 2)),
        ),
        errorWidget: (_, __, ___) => const SizedBox.shrink(),
      ),
    );
  }

  // ── bento grid (price + duration + savings) ────────────────────────────

  Widget _bentoGrid() {
    final gst = 18;
    final total = plan.price;
    final base = total / (1 + gst / 100);
    final gstAmt = total - base;
    final perDay = total / (plan.durationMonths * 30);

    return Column(
      children: [
        // Row 1: Price + Duration
        Row(
          children: [
            Expanded(
              flex: 3,
              child: _bentoBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('TOTAL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _grey, letterSpacing: 1.2)),
                    const SizedBox(height: 6),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        plan.priceDisplay,
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: _dark, letterSpacing: -1),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('incl. GST ₹${gstAmt.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 12, color: _grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: _bentoBox(
                color: _lilac,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _purple.withAlpha(25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.calendar_today_rounded, size: 18, color: _purple),
                    ),
                    const SizedBox(height: 10),
                    Text(plan.durationDisplay,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _dark)),
                    const SizedBox(height: 2),
                    Text(plan.name, style: const TextStyle(fontSize: 12, color: _grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Row 2: Per day + What's included count
        Row(
          children: [
            Expanded(
              child: _bentoBox(
                color: _mint,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _mintDark.withAlpha(25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.trending_down_rounded, size: 18, color: _mintDark),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('₹${perDay.toStringAsFixed(1)}/day',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _dark)),
                          ),
                          const Text('that\'s it', style: TextStyle(fontSize: 11, color: _grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _bentoBox(
                color: _peach,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _peachDark.withAlpha(25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.auto_awesome_rounded, size: 18, color: _peachDark),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('${_feats.isEmpty ? '10+' : _feats.length} perks',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _dark)),
                          ),
                          const Text('included', style: TextStyle(fontSize: 11, color: _grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bentoBox({required Widget child, Color? color}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color ?? _card,
        borderRadius: BorderRadius.circular(_radius),
        border: Border.all(color: color != null ? Colors.transparent : _border),
      ),
      child: child,
    );
  }

  // ── features bento ─────────────────────────────────────────────────────

  Widget _featuresBento() {
    return _bentoBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('What\'s included', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _dark)),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _feats.map((f) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle_rounded, size: 16, color: _mintDark),
                  const SizedBox(width: 6),
                  Flexible(child: Text(f, style: const TextStyle(fontSize: 13, color: _dark, fontWeight: FontWeight.w500))),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  // ── points bento ───────────────────────────────────────────────────────

  Widget _pointsBento() {
    if (_profile == null) return const SizedBox.shrink();
    final enough = _profile!.pointsBalance >= _pointsCost;

    return _bentoBox(
      color: enough ? _peach : const Color(0xFFFEF2F2),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.stars_rounded, size: 22,
                color: enough ? Colors.orange : Colors.red[400]),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your Points', style: TextStyle(fontSize: 12, color: _grey, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text('${_profile!.pointsBalance} pts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: enough ? Colors.orange[700] : Colors.red[600])),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(enough ? 'Can pay' : 'Not enough',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: enough ? _mintDark : Colors.red[600])),
          ),
        ],
      ),
    );
  }

  // ── payment bento ──────────────────────────────────────────────────────

  Widget _paymentBento() {
    return _bentoBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pay with', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _dark)),
          const SizedBox(height: 14),
          if (_profile?.isEmployee == true) ...[
            _payTile(
              method: PaymentMethod.points,
              icon: Icons.stars_rounded,
              title: 'Points',
              sub: '${_pointsCost} pts',
              accent: Colors.orange,
              enabled: _profile!.pointsBalance >= _pointsCost,
            ),
            const SizedBox(height: 8),
          ],
          _payTile(
            method: PaymentMethod.online,
            icon: Icons.account_balance_wallet_rounded,
            title: 'UPI / Net Banking / Wallet',
            sub: 'Razorpay',
            accent: const Color(0xFF3B82F6),
            enabled: true,
          ),
        ],
      ),
    );
  }

  Widget _payTile({
    required PaymentMethod method,
    required IconData icon,
    required String title,
    required String sub,
    required Color accent,
    required bool enabled,
  }) {
    final on = _method == method;
    return GestureDetector(
      onTap: enabled ? () { HapticFeedback.lightImpact(); setState(() => _method = method); } : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: on ? accent.withAlpha(12) : _bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: on ? accent.withAlpha(80) : Colors.transparent, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: enabled ? (on ? accent : _grey) : const Color(0xFFD1D5DB)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: enabled ? _dark : const Color(0xFFD1D5DB))),
                  Text(sub, style: TextStyle(fontSize: 11, color: enabled ? _grey : const Color(0xFFD1D5DB))),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22, height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: on ? accent : Colors.transparent,
                border: Border.all(color: enabled ? (on ? accent : const Color(0xFFD1D5DB)) : const Color(0xFFE5E7EB), width: 2),
              ),
              child: on ? const Icon(Icons.check_rounded, size: 14, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }

  // ── trust signals ──────────────────────────────────────────────────────

  Widget _trustSignals() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _trustChip(Icons.lock_rounded, 'Secure'),
        const SizedBox(width: 16),
        _trustChip(Icons.replay_rounded, 'Cancel anytime'),
        const SizedBox(width: 16),
        _trustChip(Icons.support_agent_rounded, '24/7 Support'),
      ],
    );
  }

  Widget _trustChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: _grey),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: _grey, fontWeight: FontWeight.w500)),
      ],
    );
  }

  // ── bottom bar ─────────────────────────────────────────────────────────

  Widget _bottomBar() {
    final isPoints = _method == PaymentMethod.points;
    final canPay = !isPoints || (_profile?.pointsBalance ?? 0) >= _pointsCost;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      decoration: const BoxDecoration(
        color: _card,
        border: Border(top: BorderSide(color: _border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total', style: TextStyle(fontSize: 11, color: _grey)),
                Text(
                  isPoints ? '$_pointsCost pts' : plan.priceDisplay,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: _dark, letterSpacing: -0.5),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: canPay && !_paying ? _handlePurchase : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _purple,
                  disabledBackgroundColor: const Color(0xFFD1D5DB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: _paying
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(
                        isPoints ? 'Redeem Points' : 'Subscribe Now',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── error ──────────────────────────────────────────────────────────────

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFFFEF2F2), shape: BoxShape.circle),
              child: Icon(Icons.error_outline_rounded, color: Colors.red[400], size: 40),
            ),
            const SizedBox(height: 20),
            const Text('Something went wrong', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: _dark)),
            const SizedBox(height: 8),
            Text(_error!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: _grey, height: 1.5)),
            const SizedBox(height: 24),
            TextButton(
              onPressed: _load,
              child: const Text('Retry', style: TextStyle(color: _purple, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  // ── business logic (unchanged) ─────────────────────────────────────────

  void _handlePurchase() {
    HapticFeedback.mediumImpact();
    _method == PaymentMethod.points ? _showPointsConfirm() : _handleOnline();
  }

  void _showPointsConfirm() {
    showModalBottomSheet(
      context: context, backgroundColor: Colors.transparent, isScrollControlled: true,
      builder: (_) => Container(
        decoration: const BoxDecoration(color: _card, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: _border, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: _peach, borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.stars_rounded, color: Colors.orange, size: 32),
              ),
              const SizedBox(height: 16),
              const Text('Confirm Points Payment', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _dark)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: _bg, borderRadius: BorderRadius.circular(14), border: Border.all(color: _border)),
                child: Column(
                  children: [
                    _cRow('Plan', plan.name, bold: true),
                    const SizedBox(height: 10),
                    _cRow('Cost', '$_pointsCost pts', color: Colors.orange),
                    const Divider(height: 20),
                    _cRow('Balance', '${_profile?.pointsBalance ?? 0} pts'),
                    const SizedBox(height: 8),
                    _cRow('After', '${(_profile?.pointsBalance ?? 0) - _pointsCost} pts', color: _mintDark),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(children: [
                Expanded(child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: _border))),
                  child: const Text('Cancel', style: TextStyle(color: _grey, fontWeight: FontWeight.w600)),
                )),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton(
                  onPressed: () { Navigator.pop(context); _processPoints(); },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.w700)),
                )),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cRow(String l, String v, {bool bold = false, Color? color}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(fontSize: 14, color: _grey)),
      Text(v, style: TextStyle(fontSize: 14, fontWeight: bold ? FontWeight.w700 : FontWeight.w600, color: color ?? _dark)),
    ]);
  }

  void _processPoints() async {
    if (_paying) return;
    setState(() => _paying = true);
    try {
      final r = await _pay.purchaseWithPoints(planId: plan.id, autoRenew: false);
      if (!mounted) return;
      setState(() => _paying = false);
      r.success ? _showSuccess('Subscription purchased with points!') : _showErr(r.message);
    } catch (e) {
      if (mounted) { setState(() => _paying = false); _showErr('$e'); }
    }
  }

  void _handleOnline() async {
    if (_paying) return;
    setState(() => _paying = true);
    try {
      final n = [_profile?.firstName, _profile?.lastName].where((s) => s != null && s.isNotEmpty).join(' ');
      final r = await _pay.processSubscriptionPayment(
        planId: plan.id, autoRenew: false,
        userPhone: _profile?.phoneNumber, userEmail: _profile?.email,
        userName: n.isNotEmpty ? n : null,
      );
      if (!mounted) return;
      setState(() => _paying = false);
      r.success ? _showSuccess('Your subscription is now active!') : _showErr(r.message);
    } catch (e) {
      if (mounted) { setState(() => _paying = false); _showErr('$e'); }
    }
  }

  void _showSuccess(String msg) {
    showDialog(context: context, barrierDismissible: false, builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(padding: const EdgeInsets.all(28), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 72, height: 72, decoration: BoxDecoration(color: _mint, shape: BoxShape.circle),
          child: const Icon(Icons.check_circle_rounded, color: _mintDark, size: 44)),
        const SizedBox(height: 20),
        const Text('You\'re all set!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: _dark)),
        const SizedBox(height: 8),
        Text(msg, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: _grey, height: 1.5)),
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, child: ElevatedButton(
          onPressed: () { Navigator.of(ctx).pop(); Navigator.of(context).pop(); },
          style: ElevatedButton.styleFrom(backgroundColor: _mintDark, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          child: const Text('Continue', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        )),
      ])),
    ));
  }

  void _showErr(String e) {
    showDialog(context: context, builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(padding: const EdgeInsets.all(28), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 72, height: 72, decoration: BoxDecoration(color: const Color(0xFFFEF2F2), shape: BoxShape.circle),
          child: Icon(Icons.error_outline_rounded, color: Colors.red[400], size: 44)),
        const SizedBox(height: 20),
        const Text('Payment Failed', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: _dark)),
        const SizedBox(height: 8),
        Text(e, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: _grey, height: 1.5)),
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, child: TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: _border))),
          child: const Text('Try Again', style: TextStyle(color: _grey, fontWeight: FontWeight.w600)),
        )),
      ])),
    ));
  }
}
