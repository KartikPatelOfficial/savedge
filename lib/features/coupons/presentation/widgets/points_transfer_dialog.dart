import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../data/models/coupon_gifting_models.dart';
import '../bloc/gifting_bloc.dart';
import '../bloc/gifting_event.dart';
import '../bloc/gifting_state.dart';

class PointsTransferDialog extends StatefulWidget {
  const PointsTransferDialog({super.key});

  @override
  State<PointsTransferDialog> createState() => _PointsTransferDialogState();
}

class _PointsTransferDialogState extends State<PointsTransferDialog> {
  final _pointsController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pointsController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GiftingBloc>(),
      child: BlocConsumer<GiftingBloc, GiftingState>(
        listener: (context, state) {
          final messenger = ScaffoldMessenger.of(context);
          final navigator = Navigator.of(context);

          if (state is GiftingSuccess) {
            if (navigator.canPop()) {
              navigator.pop();
            }
            messenger.showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF38A169),
              ),
            );
          } else if (state is GiftingError) {
            if (navigator.canPop()) {
              navigator.pop();
            }
            messenger.showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFE53E3E),
              ),
            );
          }
        },
        builder: (context, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD69E2E).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.stars,
                            color: Color(0xFFD69E2E),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Transfer Points',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Enter recipient\'s phone number to transfer points',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4A5568),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Recipient Phone Number
                    const Text(
                      'Recipient Phone Number',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9+ ]')),
                      ],
                      validator: (value) {
                        final v = (value ?? '').replaceAll(' ', '');
                        if (v.isEmpty) {
                          return 'Please enter recipient\'s phone number';
                        }
                        final phoneRegex = RegExp(r'^\+?[0-9]{10,13}$');
                        if (!phoneRegex.hasMatch(v)) {
                          return 'Enter a valid phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'e.g. +919876543210',
                        prefixIcon: const Icon(
                          Icons.phone_iphone,
                          color: Color(0xFF4A5568),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF6F3FCC),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE53E3E),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Points Amount
                    const Text(
                      'Points to Transfer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pointsController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter points amount';
                        }
                        final points = int.tryParse(value);
                        if (points == null || points <= 0) {
                          return 'Please enter a valid points amount';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter points amount',
                        prefixIcon: const Icon(
                          Icons.stars,
                          color: Color(0xFFD69E2E),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF6F3FCC),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE53E3E),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Message
                    const Text(
                      'Message (Optional)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _messageController,
                      maxLines: 3,
                      maxLength: 200,
                      decoration: InputDecoration(
                        hintText: 'Add a message for the recipient...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF6F3FCC),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4A5568),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: state is GiftingLoading
                                ? null
                                : () {
                                    final isValid =
                                        _formKey.currentState?.validate() ??
                                        false;
                                    if (!isValid) {
                                      return;
                                    }

                                    final points = int.tryParse(
                                      _pointsController.text,
                                    );
                                    if (points == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Enter a valid number of points',
                                          ),
                                          backgroundColor: Color(0xFFE53E3E),
                                        ),
                                      );
                                      return;
                                    }

                                    final phone = _phoneController.text
                                        .replaceAll(' ', '');
                                    final request = TransferPointsRequest(
                                      toUserId: phone,
                                      points: points,
                                      message:
                                          _messageController.text.trim().isEmpty
                                          ? null
                                          : _messageController.text.trim(),
                                    );
                                    context.read<GiftingBloc>().add(
                                      TransferPoints(request),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD69E2E),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: state is GiftingLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Transfer Points',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
