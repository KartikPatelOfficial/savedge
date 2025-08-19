import 'package:flutter/material.dart';

/// Search bar widget for the home page
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    this.hintText = 'Search menu, restaurant or etc',
    this.onTap,
    this.onChanged,
  });

  final String hintText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF7FAFC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search_outlined,
                color: Color(0xFF718096),
                size: 22,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  hintText,
                  style: const TextStyle(
                    color: Color(0xFF718096),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
