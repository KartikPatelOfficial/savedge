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
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ColleagueModel? _selectedColleague;

  @override
  void dispose() {
    _pointsController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GiftingBloc>()..add(const LoadColleagues()),
      child: BlocConsumer<GiftingBloc, GiftingState>(
        listener: (context, state) {
          if (state is GiftingSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF38A169),
              ),
            );
          } else if (state is GiftingError) {
            ScaffoldMessenger.of(context).showSnackBar(
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
                      'Share your points with colleagues within your organization',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4A5568),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Select Colleague
                    const Text(
                      'Select Colleague',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (state is ColleaguesLoaded) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<ColleagueModel>(
                            value: _selectedColleague,
                            hint: const Text('Choose a colleague'),
                            isExpanded: true,
                            items: state.colleagues.map((colleague) {
                              return DropdownMenuItem<ColleagueModel>(
                                value: colleague,
                                child: Text(
                                  colleague.email.isNotEmpty
                                      ? '${colleague.email} (${colleague.department})'
                                      : '${colleague.employeeCode} (${colleague.department})',
                                ),
                              );
                            }).toList(),
                            onChanged: (colleague) {
                              setState(() {
                                _selectedColleague = colleague;
                              });
                            },
                          ),
                        ),
                      ),
                    ] else if (state is GiftingLoading) ...[
                      const Center(child: CircularProgressIndicator()),
                    ] else if (state is GiftingError) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE53E3E).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Failed to load colleagues: ${state.message}',
                          style: const TextStyle(color: Color(0xFFE53E3E)),
                        ),
                      ),
                    ],
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
                        hintText: 'Add a message for your colleague...',
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
                            onPressed:
                                _selectedColleague != null &&
                                    state is! GiftingLoading &&
                                    _formKey.currentState?.validate() == true
                                ? () {
                                    final points = int.parse(
                                      _pointsController.text,
                                    );
                                    final request = TransferPointsRequest(
                                      toUserId: _selectedColleague!.userId,
                                      points: points,
                                      message:
                                          _messageController.text.trim().isEmpty
                                          ? null
                                          : _messageController.text.trim(),
                                    );
                                    context.read<GiftingBloc>().add(
                                      TransferPoints(request),
                                    );
                                  }
                                : null,
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
