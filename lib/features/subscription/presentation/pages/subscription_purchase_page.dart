import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/subscription/domain/entities/subscription_plan.dart';
import 'package:savedge/features/auth/domain/entities/extended_user_profile.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/subscription/data/services/razorpay_payment_service.dart';

/// Payment methods available for subscription purchase
enum PaymentMethod {
  points('Pay with Points'),
  razorpay('Pay with Razorpay');

  const PaymentMethod(this.displayName);
  final String displayName;
}

/// Page to purchase subscription plan with points or Razorpay
class SubscriptionPurchasePage extends StatefulWidget {
  const SubscriptionPurchasePage({super.key, required this.plan});

  final SubscriptionPlan plan;

  static Route<void> route(SubscriptionPlan plan) {
    return MaterialPageRoute(
      builder: (context) => SubscriptionPurchasePage(plan: plan),
    );
  }

  @override
  State<SubscriptionPurchasePage> createState() =>
      _SubscriptionPurchasePageState();
}

class _SubscriptionPurchasePageState extends State<SubscriptionPurchasePage> {
  ExtendedUserProfile? _userProfile;
  bool _isLoading = true;
  bool _isProcessingPayment = false;
  String? _error;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.razorpay;

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();
  RazorpayPaymentService get _razorpayService =>
      GetIt.I<RazorpayPaymentService>();

  SubscriptionPlan get plan => widget.plan;

  @override
  void initState() {
    super.initState();
    _razorpayService.initialize();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _razorpayService.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await _authRepository.getUserProfileExtended();
      if (mounted) {
        setState(() {
          _userProfile = profile;
          // Default to points payment for employees if they have enough points
          if (profile.isEmployee &&
              profile.pointsBalance >= _calculatePointsCost()) {
            _selectedPaymentMethod = PaymentMethod.points;
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  int _calculatePointsCost() {
    // Points cost should be same as the plan price
    return plan.price.round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase ${plan.name}'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? _buildErrorWidget()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plan Header
                  _buildPlanHeader(),

                  // Plan Summary
                  _buildPlanSummary(),

                  // Payment Methods
                  _buildPaymentMethods(),

                  // User Balance (if employee)
                  if (_userProfile?.isEmployee == true) _buildPointsBalance(),

                  // Purchase Button
                  _buildPurchaseButton(),

                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            Text(
              'Error loading profile',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadUserProfile,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanHeader() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: plan.hasImage
          ? null
          : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.7),
                ],
              ),
            ),
      child: plan.hasImage
          ? Image.network(
              plan.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  _buildGradientHeader(),
            )
          : _buildGradientHeader(),
    );
  }

  Widget _buildGradientHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.yellow[600], size: 48),
            const SizedBox(height: 16),
            Text(
              plan.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanSummary() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plan Summary',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildSummaryRow('Plan', plan.name),
              _buildSummaryRow('Price', plan.priceDisplay),
              _buildSummaryRow('Duration', plan.durationDisplay),
              if (plan.description != null)
                _buildSummaryRow('Description', plan.description!),
              _buildSummaryRow('Bonus Points', '${plan.bonusPoints} points'),
              _buildSummaryRow('Max Coupons', '${plan.maxCoupons}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Method',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Points Payment (for employees only)
              if (_userProfile?.isEmployee == true) ...[
                _buildPaymentOption(
                  method: PaymentMethod.points,
                  title: 'Pay with Points',
                  subtitle: '${_calculatePointsCost()} points required',
                  icon: Icons.stars,
                  color: Colors.orange,
                  enabled:
                      _userProfile!.pointsBalance >= _calculatePointsCost(),
                ),
                const SizedBox(height: 12),
              ],

              // Razorpay Payment (for all users)
              _buildPaymentOption(
                method: PaymentMethod.razorpay,
                title: 'Pay with Razorpay',
                subtitle: 'Credit/Debit Card, UPI, Net Banking',
                icon: Icons.payment,
                color: Colors.blue,
                enabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required PaymentMethod method,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool enabled,
  }) {
    final isSelected = _selectedPaymentMethod == method;

    return GestureDetector(
      onTap: enabled
          ? () {
              setState(() {
                _selectedPaymentMethod = method;
              });
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: enabled
                ? (isSelected ? color : Colors.grey[300]!)
                : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: enabled
              ? (isSelected ? color.withOpacity(0.05) : Colors.white)
              : Colors.grey[50],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: enabled ? color.withOpacity(0.1) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: enabled ? color : Colors.grey,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: enabled ? Colors.black87 : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: enabled ? Colors.grey[600] : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              if (enabled) ...[
                Radio<PaymentMethod>(
                  value: method,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    }
                  },
                  activeColor: color,
                ),
              ] else ...[
                Icon(Icons.lock_outline, color: Colors.grey[400]),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPointsBalance() {
    if (_userProfile == null) return const SizedBox.shrink();

    final hasEnoughPoints =
        _userProfile!.pointsBalance >= _calculatePointsCost();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Points Balance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${_userProfile!.pointsBalance} points available',
                      style: TextStyle(
                        fontSize: 14,
                        color: hasEnoughPoints
                            ? Colors.green[600]
                            : Colors.red[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (!hasEnoughPoints) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Insufficient',
                    style: TextStyle(
                      color: Colors.red[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPurchaseButton() {
    final isPointsPayment = _selectedPaymentMethod == PaymentMethod.points;
    final canPurchase =
        !isPointsPayment ||
        (_userProfile?.pointsBalance ?? 0) >= _calculatePointsCost();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: canPurchase && !_isProcessingPayment
              ? _handlePurchase
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isProcessingPayment
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  isPointsPayment
                      ? 'Purchase with ${_calculatePointsCost()} Points'
                      : 'Purchase ${plan.priceDisplay}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  void _handlePurchase() {
    if (_selectedPaymentMethod == PaymentMethod.points) {
      _showPointsConfirmation();
    } else {
      _handleRazorpayPayment();
    }
  }

  void _showPointsConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Points Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You are about to purchase:'),
            const SizedBox(height: 8),
            Text(
              '${plan.name} - ${plan.priceDisplay}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Points to be deducted: ${_calculatePointsCost()}'),
            Text('Current balance: ${_userProfile?.pointsBalance ?? 0}'),
            Text(
              'Balance after purchase: ${(_userProfile?.pointsBalance ?? 0) - _calculatePointsCost()}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _processPointsPayment();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm Payment'),
          ),
        ],
      ),
    );
  }

  void _processPointsPayment() async {
    if (_isProcessingPayment) return;

    setState(() {
      _isProcessingPayment = true;
    });

    try {
      final result = await _razorpayService.purchaseWithPoints(
        planId: plan.id,
        autoRenew: false,
      );

      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });

        // Check if the response contains a success message
        final message = result['message'] ?? '';
        if (message.toLowerCase().contains('successfully')) {
          _showSuccessDialog(
            'Subscription purchased successfully with points!',
          );
        } else {
          _showErrorDialog(
            result['message'] ?? 'Failed to purchase subscription',
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
        _showErrorDialog('Failed to purchase subscription: $e');
      }
    }
  }

  void _handleRazorpayPayment() async {
    if (_isProcessingPayment) return;

    setState(() {
      _isProcessingPayment = true;
    });

    try {
      await _razorpayService.processSubscriptionPayment(
        planId: plan.id,
        amount: plan.price,
        context: context,
        onSuccess: () {
          if (mounted) {
            setState(() {
              _isProcessingPayment = false;
            });
            _showSuccessDialog(
              'Payment completed! Your subscription is now active.',
            );
          }
        },
        onError: (error) {
          if (mounted) {
            setState(() {
              _isProcessingPayment = false;
            });
            _showErrorDialog(error);
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
        _showErrorDialog('Failed to initiate payment: $e');
      }
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green[600]),
            const SizedBox(width: 8),
            const Text('Success'),
          ],
        ),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to previous screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red[600]),
            const SizedBox(width: 8),
            const Text('Error'),
          ],
        ),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
