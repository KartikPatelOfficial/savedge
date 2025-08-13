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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey[500], size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  hintText,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
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