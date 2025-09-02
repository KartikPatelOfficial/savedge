import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savedge/features/points_payment/presentation/pages/points_payment_otp_page.dart';
import 'package:savedge/features/points_payment/presentation/widgets/points_input_section.dart';
import 'package:savedge/features/points_payment/presentation/widgets/bill_summary_card.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';

class PointsPaymentPage extends StatefulWidget {
  const PointsPaymentPage({
    super.key,
    required this.vendor,
    required this.availablePoints,
  });

  final Vendor vendor;
  final int availablePoints;

  @override
  State<PointsPaymentPage> createState() => _PointsPaymentPageState();
}

class _PointsPaymentPageState extends State<PointsPaymentPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final TextEditingController _billAmountController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  
  double _billAmount = 0.0;
  int _pointsToUse = 0;
  bool _isValidInput = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
    
    _billAmountController.addListener(_onBillAmountChanged);
    _pointsController.addListener(_onPointsChanged);
  }

  @override
  void dispose() {
    _billAmountController.dispose();
    _pointsController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onBillAmountChanged() {
    final amount = double.tryParse(_billAmountController.text) ?? 0.0;
    setState(() {
      _billAmount = amount;
      _validateInput();
    });
  }

  void _onPointsChanged() {
    final points = int.tryParse(_pointsController.text) ?? 0;
    setState(() {
      _pointsToUse = points;
      _validateInput();
    });
  }

  void _validateInput() {
    setState(() {
      _isValidInput = _billAmount > 0 && 
                      _pointsToUse > 0 && 
                      _pointsToUse <= widget.availablePoints &&
                      _pointsToUse <= _billAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1A202C)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Pay with Points',
          style: TextStyle(
            color: Color(0xFF1A202C),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vendor Info Card
              _buildVendorInfoCard(),
              const SizedBox(height: 24),
              
              // Bill Amount Input
              _buildBillAmountSection(),
              const SizedBox(height: 24),
              
              // Points Input Section
              PointsInputSection(
                availablePoints: widget.availablePoints,
                controller: _pointsController,
                maxPoints: _billAmount.toInt(),
              ),
              const SizedBox(height: 24),
              
              // Bill Summary
              if (_billAmount > 0 && _pointsToUse > 0)
                BillSummaryCard(
                  billAmount: _billAmount,
                  pointsUsed: _pointsToUse,
                  remainingAmount: _billAmount - _pointsToUse,
                ),
              const SizedBox(height: 32),
              
              // Proceed Button
              _buildProceedButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVendorInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.store,
              color: Color(0xFF6F3FCC),
              size: 28,
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
                  widget.vendor.category,
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
    );
  }

  Widget _buildBillAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enter Bill Amount',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _billAmountController.text.isNotEmpty
                  ? const Color(0xFF6F3FCC)
                  : Colors.grey[200]!,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _billAmountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A202C),
            ),
            decoration: InputDecoration(
              prefixText: '₹ ',
              prefixStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6F3FCC),
              ),
              hintText: '0.00',
              hintStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.grey[300],
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProceedButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: _isValidInput
            ? const LinearGradient(
                colors: [Color(0xFF6F3FCC), Color(0xFF9F7AEA)],
              )
            : null,
        color: !_isValidInput ? Colors.grey[300] : null,
        boxShadow: _isValidInput
            ? [
                BoxShadow(
                  color: const Color(0xFF6F3FCC).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isValidInput ? _handleProceed : null,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Text(
              'Proceed to Payment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _isValidInput ? Colors.white : Colors.grey[500],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleProceed() {
    if (!_isValidInput) return;
    
    HapticFeedback.lightImpact();
    
    // Navigate to OTP verification screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PointsPaymentOtpPage(
          vendor: widget.vendor,
          billAmount: _billAmount,
          pointsToUse: _pointsToUse,
        ),
      ),
    );
  }
}