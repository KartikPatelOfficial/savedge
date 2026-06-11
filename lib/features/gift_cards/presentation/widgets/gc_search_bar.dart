import 'package:flutter/material.dart';
import 'package:savedge/features/gift_cards/presentation/theme/gc_tokens.dart';

class GcSearchBar extends StatelessWidget {
  const GcSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onSubmitted,
    this.hint = 'Search brands, restaurants, stores...',
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: GcTokens.primary.withValues(alpha: 0.06),
            offset: const Offset(0, 8),
            blurRadius: 18,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        cursorColor: GcTokens.primary,
        textInputAction: TextInputAction.search,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: GcTokens.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: GcTokens.textTertiary,
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: GcTokens.primary,
            size: 22,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded, size: 17),
                    color: GcTokens.textSecondary,
                    style: IconButton.styleFrom(
                      backgroundColor: GcTokens.surfaceMuted,
                      fixedSize: const Size(30, 30),
                      minimumSize: const Size(30, 30),
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      controller.clear();
                      onChanged('');
                    },
                  ),
                )
              : null,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 46,
            minHeight: 46,
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xFFEFEAFB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: GcTokens.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
