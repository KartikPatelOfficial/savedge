import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/static_pages/data/models/contact_message_models.dart';
import 'package:savedge/features/static_pages/data/services/contact_message_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  static const _purple = Color(0xFF6F3FCC);
  static const _lightPurple = Color(0xFFEDE9FE);
  static const _dark = Color(0xFF1A202C);
  static const _grey = Color(0xFF718096);

  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isSubmitting = true);

    final service = getIt<ContactMessageService>();
    final request = SubmitContactMessageRequest(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      subject: _subjectController.text.trim().isEmpty
          ? null
          : _subjectController.text.trim(),
      message: _messageController.text.trim(),
      source: 'mobile',
    );

    try {
      await service.submitContactMessage(request);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message sent! We\'ll get back to you soon.'),
          backgroundColor: Color(0xFF059669),
        ),
      );

      _formKey.currentState?.reset();
      _fullNameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    } on DioException catch (e) {
      if (!mounted) return;
      final serverMessage = _extractErrorMessage(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            serverMessage ?? 'Unable to send your message. Please try again.',
          ),
          backgroundColor: const Color(0xFFE53E3E),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unexpected error: ${e.toString()}'),
          backgroundColor: const Color(0xFFE53E3E),
        ),
      );
    } finally {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
    }
  }

  String? _extractErrorMessage(DioException exception) {
    final responseData = exception.response?.data;
    if (responseData is Map<String, dynamic>) {
      final message = responseData['message'];
      if (message is String && message.isNotEmpty) return message;
      final errors = responseData['errors'];
      if (errors is List && errors.isNotEmpty) {
        final first = errors.first;
        if (first is String && first.isNotEmpty) return first;
      }
    }
    return exception.message;
  }

  void _launchEmail() async {
    final uri = Uri(scheme: 'mailto', path: 'info@savedge.com');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  void _launchPhone() async {
    final uri = Uri(scheme: 'tel', path: '+919909911482');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _dark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        title: const Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _dark,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildHeader(),
              const SizedBox(height: 28),
              _buildQuickActions(),
              const SizedBox(height: 32),
              _buildContactForm(context),
              const SizedBox(height: 32),
              _buildHours(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'We\'d love to\nhear from you',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: _dark,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Got a question or need help with a deal? Reach out and we\'ll get back to you fast.',
          style: TextStyle(
            fontSize: 15,
            color: _grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionCard(
            icon: Icons.email_rounded,
            label: 'Email Us',
            detail: 'info@savedge.com',
            color: const Color(0xFF6366F1),
            bgColor: const Color(0xFFEEF2FF),
            onTap: _launchEmail,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickActionCard(
            icon: Icons.phone_rounded,
            label: 'Call Us',
            detail: '+91 99099 11482',
            color: const Color(0xFF059669),
            bgColor: const Color(0xFFF0FDF4),
            onTap: _launchPhone,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String label,
    required String detail,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              detail,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: _grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Send a message',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: _dark,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Fill out the form and we\'ll respond within 24 hours.',
          style: TextStyle(fontSize: 13, color: _grey),
        ),
        const SizedBox(height: 20),
        Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(
                hint: 'Full name',
                controller: _fullNameController,
                icon: Icons.person_outline_rounded,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) return 'Full name is required';
                  if (text.length < 3) return 'At least 3 characters';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildField(
                hint: 'Email address',
                controller: _emailController,
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) return 'Email is required';
                  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                  if (!emailRegex.hasMatch(text)) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildField(
                hint: 'Subject (optional)',
                controller: _subjectController,
                icon: Icons.tag_rounded,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.length > 200) return 'Under 200 characters';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildField(
                hint: 'Your message...',
                controller: _messageController,
                icon: Icons.edit_note_rounded,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) return 'Please tell us how we can help';
                  if (text.length < 10) return 'At least 10 characters';
                  if (text.length > 2000) return 'Under 2000 characters';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: _isSubmitting ? null : () => _submitForm(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: _purple,
                    disabledBackgroundColor: _purple.withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Send Message',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction:
          textInputAction ?? (maxLines > 1 ? TextInputAction.newline : TextInputAction.next),
      maxLines: maxLines,
      minLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 14, right: 10),
          child: Icon(icon, color: _grey, size: 20),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        hintText: hint,
        hintStyle: const TextStyle(color: _grey, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF7F7F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _purple, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE53E3E)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE53E3E), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildHours() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.schedule_rounded, color: _purple, size: 20),
              SizedBox(width: 8),
              Text(
                'Support Hours',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _dark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHourRow('Mon - Fri', '9:00 AM - 6:00 PM'),
          const SizedBox(height: 8),
          _buildHourRow('Saturday', '10:00 AM - 4:00 PM'),
          const SizedBox(height: 8),
          _buildHourRow('Sunday', 'Closed'),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _lightPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '⚡ Urgent? Our live chat is available 24/7',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _purple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourRow(String day, String hours) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _dark,
          ),
        ),
        Text(
          hours,
          style: const TextStyle(
            fontSize: 14,
            color: _grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
