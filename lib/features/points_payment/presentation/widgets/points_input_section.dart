import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PointsInputSection extends StatelessWidget {
  const PointsInputSection({
    super.key,
    required this.availablePoints,
    required this.controller,
    required this.maxPoints,
  });

  final int availablePoints;
  final TextEditingController controller;
  final int maxPoints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Points to Use',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.stars,
                    color: Color(0xFF6F3FCC),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$availablePoints available',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6F3FCC),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: controller.text.isNotEmpty
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
          child: Column(
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(16),
                    child: const Icon(
                      Icons.stars,
                      color: Color(0xFF6F3FCC),
                      size: 24,
                    ),
                  ),
                  hintText: '0',
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[300],
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _MaxValueInputFormatter(
                    maxValue: maxPoints > 0 
                        ? (maxPoints < availablePoints ? maxPoints : availablePoints)
                        : availablePoints,
                  ),
                ],
              ),
              // Quick selection buttons
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildQuickSelectButton('25%', () {
                      final value = (maxPoints * 0.25).toInt();
                      controller.text = value.toString();
                    }),
                    _buildQuickSelectButton('50%', () {
                      final value = (maxPoints * 0.50).toInt();
                      controller.text = value.toString();
                    }),
                    _buildQuickSelectButton('75%', () {
                      final value = (maxPoints * 0.75).toInt();
                      controller.text = value.toString();
                    }),
                    _buildQuickSelectButton('MAX', () {
                      final maxAllowed = maxPoints > 0 
                          ? (maxPoints < availablePoints ? maxPoints : availablePoints)
                          : availablePoints;
                      controller.text = maxAllowed.toString();
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '1 Point = ₹1',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickSelectButton(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF6F3FCC).withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6F3FCC),
          ),
        ),
      ),
    );
  }
}

class _MaxValueInputFormatter extends TextInputFormatter {
  final int maxValue;

  _MaxValueInputFormatter({required this.maxValue});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value == null) {
      return oldValue;
    }

    if (value > maxValue) {
      return TextEditingValue(
        text: maxValue.toString(),
        selection: TextSelection.collapsed(offset: maxValue.toString().length),
      );
    }

    return newValue;
  }
}