import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:savedge/features/points_payment/data/models/points_payment_models.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:share_plus/share_plus.dart';

class PointsPaymentSuccessPage extends StatefulWidget {
  const PointsPaymentSuccessPage({
    super.key,
    required this.paymentResponse,
    required this.vendor,
  });

  final VerifyPointsPaymentOtpResponse paymentResponse;
  final Vendor vendor;

  @override
  State<PointsPaymentSuccessPage> createState() => _PointsPaymentSuccessPageState();
}

class _PointsPaymentSuccessPageState extends State<PointsPaymentSuccessPage>
    with TickerProviderStateMixin {
  late AnimationController _checkmarkController;
  late AnimationController _contentController;
  late Animation<double> _checkmarkAnimation;
  late Animation<double> _contentAnimation;

  @override
  void initState() {
    super.initState();
    _checkmarkController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _checkmarkAnimation = CurvedAnimation(
      parent: _checkmarkController,
      curve: Curves.elasticOut,
    );
    _contentAnimation = CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeOutCubic,
    );
    
    _checkmarkController.forward();
    Future.delayed(const Duration(milliseconds: 600), () {
      _contentController.forward();
    });
    
    HapticFeedback.heavyImpact();
  }

  @override
  void dispose() {
    _checkmarkController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFD),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                // Success Animation
                ScaleTransition(
                  scale: _checkmarkAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF38A169), Color(0xFF68D391)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF38A169).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Success Text
                FadeTransition(
                  opacity: _contentAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).animate(_contentAnimation),
                    child: Column(
                      children: [
                        const Text(
                          'Payment Successful!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A202C),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Points payment completed',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                
                // Payment Details Card
                FadeTransition(
                  opacity: _contentAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(_contentAnimation),
                    child: _buildPaymentDetailsCard(),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Action Buttons
                FadeTransition(
                  opacity: _contentAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.4),
                      end: Offset.zero,
                    ).animate(_contentAnimation),
                    child: _buildActionButtons(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
    final dateFormatter = DateFormat('dd MMM yyyy, hh:mm a');
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Transaction Reference
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.paymentResponse.transactionReference,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6F3FCC),
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Vendor Info
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.store,
                  color: Color(0xFF6F3FCC),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.vendor.businessName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateFormatter.format(widget.paymentResponse.completedAt),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Payment Summary
          _buildSummaryItem(
            'Bill Amount',
            '₹${widget.paymentResponse.billAmount.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          _buildSummaryItem(
            'Points Used',
            '-₹${widget.paymentResponse.pointsUsed.toStringAsFixed(2)}',
            valueColor: const Color(0xFF38A169),
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.grey[200],
          ),
          const SizedBox(height: 16),
          _buildSummaryItem(
            'Amount Paid',
            '₹${widget.paymentResponse.paidAmount.toStringAsFixed(2)}',
            isTotal: true,
          ),
          
          if (widget.paymentResponse.remainingAmount > 0) ...[
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD69E2E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD69E2E).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFD69E2E),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Remaining Amount',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD69E2E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹${widget.paymentResponse.remainingAmount.toStringAsFixed(2)} to be paid at store',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF744210),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, {
    Color? valueColor,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 15,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            color: valueColor ?? const Color(0xFF1A202C),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Share Button
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF6F3FCC),
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _shareReceipt,
              borderRadius: BorderRadius.circular(16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.share,
                    color: Color(0xFF6F3FCC),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Share Receipt',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6F3FCC),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Done Button
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF6F3FCC), Color(0xFF9F7AEA)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6F3FCC).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              borderRadius: BorderRadius.circular(16),
              child: const Center(
                child: Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _shareReceipt() {
    final dateFormatter = DateFormat('dd MMM yyyy, hh:mm a');
    final receiptText = '''
Payment Receipt

Transaction Reference: ${widget.paymentResponse.transactionReference}
Date: ${dateFormatter.format(widget.paymentResponse.completedAt)}

Vendor: ${widget.vendor.businessName}
Bill Amount: ₹${widget.paymentResponse.billAmount.toStringAsFixed(2)}
Points Used: ${widget.paymentResponse.pointsUsed} (₹${widget.paymentResponse.pointsUsed.toStringAsFixed(2)})
Amount Paid: ₹${widget.paymentResponse.paidAmount.toStringAsFixed(2)}
${widget.paymentResponse.remainingAmount > 0 ? 'Remaining: ₹${widget.paymentResponse.remainingAmount.toStringAsFixed(2)}' : ''}

Thank you for using Savedge!
''';

    Share.share(receiptText, subject: 'Savedge Payment Receipt');
  }
}