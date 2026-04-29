import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

const Color _primary = Color(0xFF6F3FCC);
const Color _secondary = Color(0xFF8B5CF6);
const Color _mint = Color(0xFF10B981);
const Color _teal = Color(0xFF14B8A6);
const Color _amber = Color(0xFFF59E0B);
const Color _coral = Color(0xFFEF6C35);
const Color _textPrimary = Color(0xFF1A202C);
const Color _textMuted = Color(0xFF6B7280);
const Color _pageBackground = Color(0xFFF8FAFD);
const Color _border = Color(0xFFE7EAF1);
const Color _inputSurface = Color(0xFFF7F9FC);

/// Edit profile page for updating user information.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.userProfile});

  final UserProfileResponse3 userProfile;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  final DateFormat _monthYearFormat = DateFormat('MMM yyyy');

  bool _isLoading = false;
  bool _isEmployee = false;
  bool _hasChanges = false;

  DateTime? _dateOfBirth;
  DateTime? _anniversaryDate;
  String? _selectedState;

  static const List<String> _indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi',
    'Jammu and Kashmir',
    'Ladakh',
    'Lakshadweep',
    'Puducherry',
  ];

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  UserProfileResponse3 get _profile => widget.userProfile;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupAnimations();
  }

  void _initializeControllers() {
    _firstNameController.text = _profile.firstName;
    _lastNameController.text = _profile.lastName;
    _emailController.text = _profile.email;
    _phoneController.text = _profile.phoneNumber;
    _addressController.text = _profile.residentialAddress ?? '';
    _cityController.text = _profile.city ?? '';
    _pinCodeController.text = _profile.pinCode ?? '';
    _selectedState = _indianStates.contains(_profile.state)
        ? _profile.state
        : null;
    _isEmployee = _profile.isEmployee;
    _dateOfBirth = _profile.dateOfBirth;
    _anniversaryDate = _profile.anniversaryDate;

    for (final TextEditingController controller in [
      _firstNameController,
      _lastNameController,
      _phoneController,
      _addressController,
      _cityController,
      _pinCodeController,
    ]) {
      controller.addListener(_checkForChanges);
    }
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 650),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  void _checkForChanges() {
    final bool hasChanges =
        _firstNameController.text.trim() != _profile.firstName.trim() ||
        _lastNameController.text.trim() != _profile.lastName.trim() ||
        _phoneController.text.trim() != _profile.phoneNumber.trim() ||
        _addressController.text.trim() !=
            (_profile.residentialAddress ?? '').trim() ||
        _cityController.text.trim() != (_profile.city ?? '').trim() ||
        (_selectedState ?? '').trim() != (_profile.state ?? '').trim() ||
        _pinCodeController.text.trim() != (_profile.pinCode ?? '').trim() ||
        !_sameDate(_dateOfBirth, _profile.dateOfBirth) ||
        !_sameDate(_anniversaryDate, _profile.anniversaryDate);

    if (hasChanges != _hasChanges) {
      setState(() => _hasChanges = hasChanges);
    }
  }

  bool _sameDate(DateTime? left, DateTime? right) {
    if (left == null && right == null) {
      return true;
    }

    if (left == null || right == null) {
      return false;
    }

    return left.year == right.year &&
        left.month == right.month &&
        left.day == right.day;
  }

  int get _occasionCount => [
    _dateOfBirth,
    _anniversaryDate,
  ].where((DateTime? date) => date != null).length;

  int get _filledDetailsCount {
    int count = 0;

    for (final String value in [
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _phoneController.text.trim(),
      _addressController.text.trim(),
      _cityController.text.trim(),
      (_selectedState ?? '').trim(),
      _pinCodeController.text.trim(),
    ]) {
      if (value.isNotEmpty) {
        count++;
      }
    }

    return count + _occasionCount;
  }

  double get _completionRatio => _filledDetailsCount / 9;

  int get _missingFieldCount => 9 - _filledDetailsCount;

  int get _changedFieldCount {
    int count = 0;

    if (_firstNameController.text.trim() != _profile.firstName.trim()) {
      count++;
    }
    if (_lastNameController.text.trim() != _profile.lastName.trim()) {
      count++;
    }
    if (_phoneController.text.trim() != _profile.phoneNumber.trim()) {
      count++;
    }
    if (_addressController.text.trim() !=
        (_profile.residentialAddress ?? '').trim()) {
      count++;
    }
    if (_cityController.text.trim() != (_profile.city ?? '').trim()) {
      count++;
    }
    if ((_selectedState ?? '').trim() != (_profile.state ?? '').trim()) {
      count++;
    }
    if (_pinCodeController.text.trim() != (_profile.pinCode ?? '').trim()) {
      count++;
    }
    if (!_sameDate(_dateOfBirth, _profile.dateOfBirth)) {
      count++;
    }
    if (!_sameDate(_anniversaryDate, _profile.anniversaryDate)) {
      count++;
    }

    return count;
  }

  String get _memberSince => _monthYearFormat.format(_profile.createdAt);

  String get _locationCardValue {
    if (_cityController.text.trim().isNotEmpty) {
      return _cityController.text.trim();
    }

    if ((_selectedState ?? '').trim().isNotEmpty) {
      return _selectedState!.trim();
    }

    return 'Add';
  }

  String get _locationCardSubtitle {
    final List<String> parts = [
      if ((_selectedState ?? '').trim().isNotEmpty) _selectedState!.trim(),
      if (_pinCodeController.text.trim().isNotEmpty)
        'PIN ${_pinCodeController.text.trim()}',
    ];

    if (parts.isEmpty) {
      return 'Set your city and state';
    }

    return parts.join(' • ');
  }

  String get _fullLocation {
    final List<String> parts = [
      _addressController.text.trim(),
      _cityController.text.trim(),
      (_selectedState ?? '').trim(),
      _pinCodeController.text.trim(),
    ].where((String value) => value.isNotEmpty).toList();

    if (parts.isEmpty) {
      return 'No address added yet';
    }

    return parts.join(', ');
  }

  Color get _heroAccent => _isEmployee ? _amber : _primary;

  @override
  void dispose() {
    for (final TextEditingController controller in [
      _firstNameController,
      _lastNameController,
      _phoneController,
      _addressController,
      _cityController,
      _pinCodeController,
    ]) {
      controller.removeListener(_checkForChanges);
      controller.dispose();
    }

    _emailController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBackground,
      bottomNavigationBar: _isEmployee ? null : _buildBottomActionBar(),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            _buildSliverAppBar(context),
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    child: _buildPageBody(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 148,
      backgroundColor: Colors.transparent,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: _textPrimary),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: _textPrimary,
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          const double expandedHeight = 148;
          final double minHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;
          final double t =
              ((constraints.maxHeight - minHeight) /
                      (expandedHeight - minHeight))
                  .clamp(0.0, 1.0);
          final double leftPadding = 20 + (52 * (1 - t));

          return Container(
            decoration: BoxDecoration(
              color: Color.lerp(Colors.white, Colors.transparent, t),
            ),
            child: Stack(
              children: [
                if (t > 0.05)
                  Positioned(
                    bottom: 52,
                    left: 20,
                    child: Opacity(
                      opacity: t,
                      child: Text(
                        _isEmployee
                            ? 'Read-only profile managed by your organization'
                            : 'Refresh the details your account depends on',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                  ),
                FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.only(
                    left: leftPadding,
                    bottom: 16,
                    right: 20,
                  ),
                  title: Text(
                    _isEmployee ? 'Profile Details' : 'Edit Profile',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: t > 0.5 ? 24 : 20,
                      fontWeight: t > 0.5 ? FontWeight.w800 : FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageBody() {
    return Column(
      children: [
        _buildHeroCard(),
        const SizedBox(height: 16),
        if (_isEmployee) ...[
          _buildEmployeeLayout(),
        ] else ...[
          _buildOverviewGrid(),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildIdentityPanel(),
                const SizedBox(height: 16),
                _buildAddressPanel(),
                const SizedBox(height: 16),
                _buildOccasionPanel(),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildHeroCard() {
    final String title = _profile.displayName.isNotEmpty
        ? _profile.displayName
        : 'Your profile';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: const Color(0xFFFCFBFF),
        border: Border.all(color: _heroAccent.withValues(alpha: 0.10)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: -42,
            top: -58,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _heroAccent.withValues(alpha: 0.24),
                    _heroAccent.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -54,
            bottom: -68,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    (_isEmployee ? _coral : _secondary).withValues(alpha: 0.22),
                    (_isEmployee ? _coral : _secondary).withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      _isEmployee ? 'Managed profile' : 'Profile studio',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                        color: _textPrimary.withValues(alpha: 0.45),
                      ),
                    ),
                    const Spacer(),
                    _CapsuleBadge(
                      label: _profile.primaryRole,
                      accent: _heroAccent,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAvatar(),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: _textPrimary,
                              height: 1.05,
                              letterSpacing: -0.8,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _profile.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _textPrimary.withValues(alpha: 0.54),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _InlinePill(
                                icon: _profile.isActive
                                    ? Icons.verified_outlined
                                    : Icons.pause_circle_outline_rounded,
                                label: _profile.isActive
                                    ? 'Active account'
                                    : 'Inactive',
                                accent: _profile.isActive ? _mint : Colors.grey,
                              ),
                              _InlinePill(
                                icon: _isEmployee
                                    ? Icons.apartment_rounded
                                    : (_hasChanges
                                          ? Icons.edit_note_rounded
                                          : Icons.cloud_done_outlined),
                                label: _isEmployee
                                    ? (_profile.organizationName ??
                                          'Organization managed')
                                    : (_hasChanges
                                          ? '$_changedFieldCount draft change${_changedFieldCount == 1 ? '' : 's'}'
                                          : 'Live profile'),
                                accent: _isEmployee
                                    ? _amber
                                    : (_hasChanges ? _coral : _mint),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _buildResponsivePair(
                  _HeroMetricTile(
                    value: _isEmployee
                        ? (_profile.employeeInfo?.employeeCode ?? 'N/A')
                        : '${(_completionRatio * 100).round()}%',
                    label: _isEmployee ? 'employee code' : 'completion',
                    accent: _heroAccent,
                  ),
                  _HeroMetricTile(
                    value: _isEmployee
                        ? '${_profile.pointsBalance}'
                        : '$_occasionCount/2',
                    label: _isEmployee ? 'points ready' : 'special dates',
                    accent: _isEmployee ? _mint : _amber,
                  ),
                  rightFlex: 1,
                  leftFlex: 1,
                ),
                const SizedBox(height: 10),
                _buildResponsivePair(
                  _HeroMetricTile(
                    value: _memberSince,
                    label: 'member since',
                    accent: _teal,
                  ),
                  _HeroMetricTile(
                    value: _isEmployee
                        ? (_profile.employeeInfo?.department ?? 'Team')
                        : (_hasChanges ? '$_changedFieldCount' : '0'),
                    label: _isEmployee ? 'department' : 'pending edits',
                    accent: _isEmployee ? _coral : _mint,
                  ),
                  rightFlex: 1,
                  leftFlex: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final String initials = [
      if (_profile.firstName.isNotEmpty) _profile.firstName.trim()[0],
      if (_profile.lastName.isNotEmpty) _profile.lastName.trim()[0],
    ].join().toUpperCase();

    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_heroAccent, (_isEmployee ? _coral : _secondary)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _heroAccent.withValues(alpha: 0.20),
            blurRadius: 24,
            spreadRadius: -12,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials.isNotEmpty ? initials : 'SE',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewGrid() {
    return Column(
      children: [
        _buildResponsivePair(
          _InsightTile(
            accent: _primary,
            icon: Icons.checklist_rounded,
            title: 'Profile completion',
            value: '${(_completionRatio * 100).round()}%',
            subtitle: _missingFieldCount == 0
                ? 'Everything important looks filled in'
                : '$_missingFieldCount optional detail${_missingFieldCount == 1 ? '' : 's'} left',
          ),
          _InsightTile(
            accent: _amber,
            icon: Icons.celebration_outlined,
            title: 'Occasion perks',
            value: '$_occasionCount/2',
            subtitle: _occasionCount == 0
                ? 'Add dates for birthday and anniversary offers'
                : 'Dates are ready for special-day promos',
          ),
          leftFlex: 6,
          rightFlex: 5,
        ),
        const SizedBox(height: 12),
        _buildResponsivePair(
          _InsightTile(
            accent: _teal,
            icon: Icons.place_outlined,
            title: 'Location',
            value: _locationCardValue,
            subtitle: _locationCardSubtitle,
          ),
          _InsightTile(
            accent: _hasChanges ? _coral : _mint,
            icon: _hasChanges
                ? Icons.edit_note_rounded
                : Icons.cloud_done_outlined,
            title: _hasChanges ? 'Draft changes' : 'Save state',
            value: _hasChanges
                ? '$_changedFieldCount field${_changedFieldCount == 1 ? '' : 's'} edited'
                : 'Everything saved',
            subtitle: _hasChanges
                ? 'Use the action bar below when you are ready'
                : 'Your current profile is already in sync',
          ),
          leftFlex: 5,
          rightFlex: 6,
        ),
      ],
    );
  }

  Widget _buildIdentityPanel() {
    return _BentoPanel(
      accent: _primary,
      icon: Icons.badge_outlined,
      eyebrow: 'Identity',
      title: 'Personal details',
      subtitle:
          'These basics show up across your account, invoices, and support conversations.',
      child: Column(
        children: [
          _buildResponsivePair(
            _buildInputTile(
              controller: _firstNameController,
              label: 'First name',
              icon: Icons.person_outline_rounded,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'First name is required';
                }
                return null;
              },
            ),
            _buildInputTile(
              controller: _lastNameController,
              label: 'Last name',
              icon: Icons.person_2_outlined,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Last name is required';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 12),
          _buildResponsivePair(
            _buildInputTile(
              controller: _phoneController,
              label: 'Mobile number',
              icon: Icons.call_outlined,
              keyboardType: TextInputType.phone,
              validator: (String? value) {
                if (value != null &&
                    value.isNotEmpty &&
                    value.trim().length < 10) {
                  return 'Enter a valid mobile number';
                }
                return null;
              },
            ),
            _ReadonlyTile(
              accent: _secondary,
              icon: Icons.lock_outline_rounded,
              label: 'Email address',
              value: _profile.email,
              hint: 'Locked for security. Contact support if it must change.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressPanel() {
    return _BentoPanel(
      accent: _teal,
      icon: Icons.home_work_outlined,
      eyebrow: 'Reach',
      title: 'Address and locality',
      subtitle:
          'Location helps us tailor communication, nearby offers, and region-specific experiences.',
      child: Column(
        children: [
          _buildInputTile(
            controller: _addressController,
            label: 'Residential address',
            icon: Icons.home_outlined,
            keyboardType: TextInputType.streetAddress,
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          _buildResponsivePair(
            _buildInputTile(
              controller: _cityController,
              label: 'City',
              icon: Icons.location_city_outlined,
            ),
            _buildStateDropdownTile(),
          ),
          const SizedBox(height: 12),
          _buildResponsivePair(
            _buildInputTile(
              controller: _pinCodeController,
              label: 'PIN code',
              icon: Icons.pin_drop_outlined,
              keyboardType: TextInputType.number,
              validator: (String? value) {
                if (value != null &&
                    value.isNotEmpty &&
                    value.trim().length != 6) {
                  return 'Enter a valid 6-digit pin code';
                }
                return null;
              },
            ),
            _ReadonlyTile(
              accent: _teal,
              icon: Icons.explore_outlined,
              label: 'Location preview',
              value: _fullLocation,
              hint: 'How this part of the profile currently reads.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOccasionPanel() {
    return _BentoPanel(
      accent: _amber,
      icon: Icons.cake_outlined,
      eyebrow: 'Perks',
      title: 'Dates that matter',
      subtitle:
          'Birthday and anniversary dates unlock timely rewards and special-day nudges.',
      child: Column(
        children: [
          _buildResponsivePair(
            _buildDateTile(
              label: 'Birthday',
              icon: Icons.cake_rounded,
              value: _dateOfBirth,
              helperText: 'Birthday offers and reminders',
              onTap: () => _selectDate(context, true),
            ),
            _buildDateTile(
              label: 'Anniversary',
              icon: Icons.favorite_outline_rounded,
              value: _anniversaryDate,
              helperText: 'Anniversary coupons and surprises',
              onTap: () => _selectDate(context, false),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: _amber.withValues(alpha: 0.14)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: _amber.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    size: 18,
                    color: _amber,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _occasionCount == 0
                        ? 'Add one or both dates to make the app feel more personal and unlock special-day drops.'
                        : 'Great. Your profile is ready to receive occasion-based offers when those dates come around.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                      color: _textPrimary.withValues(alpha: 0.68),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeLayout() {
    final EmployeeInfo? employee = _profile.employeeInfo;

    return Column(
      children: [
        _BentoPanel(
          accent: _amber,
          icon: Icons.business_center_outlined,
          eyebrow: 'Managed',
          title: employee?.organizationName ?? 'Organization managed',
          subtitle:
              'Your official profile is controlled by your organization. Reach out to HR or your admin for changes.',
          child: Column(
            children: [
              _buildResponsivePair(
                _ReadonlyTile(
                  accent: _amber,
                  icon: Icons.badge_outlined,
                  label: 'Employee code',
                  value: employee?.employeeCode ?? 'Not available',
                  hint: 'Unique ID assigned by your organization.',
                ),
                _ReadonlyTile(
                  accent: _mint,
                  icon: Icons.stars_rounded,
                  label: 'Available points',
                  value: '${_profile.pointsBalance}',
                  hint: 'Current reward balance linked to your account.',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildResponsivePair(
          _InsightTile(
            accent: _primary,
            icon: Icons.account_tree_outlined,
            title: 'Department',
            value: employee?.department ?? 'Not set',
            subtitle: 'Your current team or unit',
          ),
          _InsightTile(
            accent: _teal,
            icon: Icons.work_outline_rounded,
            title: 'Position',
            value: employee?.position ?? 'Not set',
            subtitle: 'Your role in the organization',
          ),
          leftFlex: 1,
          rightFlex: 1,
        ),
        const SizedBox(height: 16),
        _BentoPanel(
          accent: _primary,
          icon: Icons.contact_page_outlined,
          eyebrow: 'Snapshot',
          title: 'Contact details',
          subtitle:
              'These are the contact points currently registered against your managed profile.',
          child: Column(
            children: [
              _ReadonlyTile(
                accent: _primary,
                icon: Icons.person_outline_rounded,
                label: 'Full name',
                value: _profile.displayName,
                hint: 'Used across your account and activity.',
              ),
              const SizedBox(height: 12),
              _buildResponsivePair(
                _ReadonlyTile(
                  accent: _secondary,
                  icon: Icons.call_outlined,
                  label: 'Mobile number',
                  value: _profile.phoneNumber,
                ),
                _ReadonlyTile(
                  accent: _secondary,
                  icon: Icons.email_outlined,
                  label: 'Email address',
                  value: _profile.email,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _BentoPanel(
          accent: _teal,
          icon: Icons.place_outlined,
          eyebrow: 'Location',
          title: 'Address overview',
          subtitle: 'Your current address and locality details on record.',
          child: Column(
            children: [
              _ReadonlyTile(
                accent: _teal,
                icon: Icons.home_outlined,
                label: 'Address',
                value: _fullLocation,
                hint:
                    'Contact your organization if any part of this needs updating.',
              ),
              if (_profile.dateOfBirth != null ||
                  _profile.anniversaryDate != null) ...[
                const SizedBox(height: 12),
                _buildResponsivePair(
                  _ReadonlyTile(
                    accent: _amber,
                    icon: Icons.cake_outlined,
                    label: 'Birthday',
                    value: _profile.dateOfBirth != null
                        ? _dateFormat.format(_profile.dateOfBirth!)
                        : 'Not added',
                  ),
                  _ReadonlyTile(
                    accent: _coral,
                    icon: Icons.favorite_outline_rounded,
                    label: 'Anniversary',
                    value: _profile.anniversaryDate != null
                        ? _dateFormat.format(_profile.anniversaryDate!)
                        : 'Not added',
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildBottomActionBar() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _border),
            boxShadow: [
              BoxShadow(
                color: _primary.withValues(alpha: 0.10),
                blurRadius: 26,
                spreadRadius: -16,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: _hasChanges ? _amber : _mint,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _hasChanges
                          ? '$_changedFieldCount pending change${_changedFieldCount == 1 ? '' : 's'} ready to save'
                          : 'No pending changes right now',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: _textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    _hasChanges ? 'Draft' : 'Synced',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: (_hasChanges ? _amber : _mint).withValues(
                        alpha: 0.95,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading
                          ? null
                          : () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        foregroundColor: _textPrimary,
                        side: const BorderSide(color: _border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _hasChanges ? null : const Color(0xFFE5E7EB),
                        gradient: _hasChanges
                            ? const LinearGradient(
                                colors: [_primary, _secondary],
                              )
                            : null,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: _hasChanges
                            ? [
                                BoxShadow(
                                  color: _primary.withValues(alpha: 0.25),
                                  blurRadius: 22,
                                  spreadRadius: -14,
                                  offset: const Offset(0, 14),
                                ),
                              ]
                            : null,
                      ),
                      child: ElevatedButton(
                        onPressed: (_isLoading || !_hasChanges)
                            ? null
                            : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _hasChanges
                                        ? Icons.save_outlined
                                        : Icons.cloud_done_outlined,
                                    size: 18,
                                    color: _hasChanges
                                        ? Colors.white
                                        : _textMuted,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _hasChanges
                                        ? 'Save ${_changedFieldCount == 0 ? '' : _changedFieldCount} change${_changedFieldCount == 1 ? '' : 's'}'
                                        : 'Save changes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: _hasChanges
                                          ? Colors.white
                                          : _textMuted,
                                    ),
                                  ),
                                ],
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
  }

  Widget _buildInputTile({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hintText,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    final bool isMultiline = maxLines > 1;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldHeader(icon: icon, label: label, accent: _primary),
          const SizedBox(height: 12),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            minLines: isMultiline ? maxLines : 1,
            maxLines: maxLines,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
            ),
            decoration: _buildInputDecoration(
              hintText: hintText,
              isMultiline: isMultiline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateDropdownTile() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FieldHeader(
            icon: Icons.map_outlined,
            label: 'State',
            accent: _teal,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedState,
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: _textPrimary.withValues(alpha: 0.40),
            ),
            decoration: _buildInputDecoration(hintText: 'Choose a state'),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
            ),
            dropdownColor: Colors.white,
            menuMaxHeight: 320,
            items: _indianStates
                .map(
                  (String state) => DropdownMenuItem<String>(
                    value: state,
                    child: Text(state, overflow: TextOverflow.ellipsis),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              setState(() => _selectedState = value);
              _checkForChanges();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateTile({
    required String label,
    required IconData icon,
    required DateTime? value,
    required String helperText,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldHeader(icon: icon, label: label, accent: _amber),
              const SizedBox(height: 12),
              Text(
                value != null ? _dateFormat.format(value) : 'Add date',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: value != null
                      ? _textPrimary
                      : _textPrimary.withValues(alpha: 0.34),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      helperText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.35,
                        color: _textPrimary.withValues(alpha: 0.46),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: _textPrimary.withValues(alpha: 0.38),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsivePair(
    Widget left,
    Widget right, {
    int leftFlex = 1,
    int rightFlex = 1,
  }) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 340) {
          return Column(children: [left, const SizedBox(height: 12), right]);
        }

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: leftFlex, child: left),
              const SizedBox(width: 12),
              Expanded(flex: rightFlex, child: right),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _buildInputDecoration({
    String? hintText,
    bool isMultiline = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: _textPrimary.withValues(alpha: 0.28),
      ),
      filled: true,
      fillColor: _inputSurface,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: isMultiline ? 14 : 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: _border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: _primary, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFFE53E3E)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFFE53E3E), width: 1.8),
      ),
      errorStyle: const TextStyle(height: 1.2),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isBirthday) async {
    final DateTime? currentValue = isBirthday ? _dateOfBirth : _anniversaryDate;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentValue ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: _primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: _textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isBirthday) {
          _dateOfBirth = picked;
        } else {
          _anniversaryDate = picked;
        }
      });
      _checkForChanges();
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() => _isLoading = true);

      await _authRepository.updateCurrentUserProfile(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNumber: _phoneController.text.trim().isNotEmpty
            ? _phoneController.text.trim()
            : null,
        residentialAddress: _addressController.text.trim().isNotEmpty
            ? _addressController.text.trim()
            : null,
        city: _cityController.text.trim().isNotEmpty
            ? _cityController.text.trim()
            : null,
        state: (_selectedState ?? '').trim().isNotEmpty ? _selectedState : null,
        pinCode: _pinCodeController.text.trim().isNotEmpty
            ? _pinCodeController.text.trim()
            : null,
        dateOfBirth: _dateOfBirth,
        anniversaryDate: _anniversaryDate,
      );

      if (!mounted) {
        return;
      }

      final bool hasNewOccasionDates =
          (_dateOfBirth != null || _anniversaryDate != null) &&
          (_profile.dateOfBirth == null && _profile.anniversaryDate == null);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.green,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  hasNewOccasionDates
                      ? 'Profile updated. Special-day offers are now unlocked for your account.'
                      : 'Profile updated successfully.',
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(child: Text('Error: $e')),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

class _BentoPanel extends StatelessWidget {
  const _BentoPanel({
    required this.accent,
    required this.icon,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final Color accent;
  final IconData icon;
  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
        border: Border.all(color: accent.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 24,
            spreadRadius: -16,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -36,
            top: -42,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    accent.withValues(alpha: 0.14),
                    accent.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(icon, size: 20, color: accent),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eyebrow.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                              color: accent.withValues(alpha: 0.90),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: _textPrimary,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              height: 1.45,
                              color: _textPrimary.withValues(alpha: 0.56),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({
    required this.accent,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final Color accent;
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accent.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 22,
            spreadRadius: -16,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 18, color: accent),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _textPrimary.withValues(alpha: 0.46),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: _textPrimary,
              height: 1.1,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.35,
              color: _textPrimary.withValues(alpha: 0.50),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroMetricTile extends StatelessWidget {
  const _HeroMetricTile({
    required this.value,
    required this.label,
    required this.accent,
  });

  final String value;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: _textPrimary,
              height: 1.05,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.8,
              color: accent.withValues(alpha: 0.90),
            ),
          ),
        ],
      ),
    );
  }
}

class _CapsuleBadge extends StatelessWidget {
  const _CapsuleBadge({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: accent,
        ),
      ),
    );
  }
}

class _InlinePill extends StatelessWidget {
  const _InlinePill({
    required this.icon,
    required this.label,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: accent),
          const SizedBox(width: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 180),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldHeader extends StatelessWidget {
  const _FieldHeader({
    required this.icon,
    required this.label,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 17, color: accent),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: _textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReadonlyTile extends StatelessWidget {
  const _ReadonlyTile({
    required this.accent,
    required this.icon,
    required this.label,
    required this.value,
    this.hint,
  });

  final Color accent;
  final IconData icon;
  final String label;
  final String value;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldHeader(icon: icon, label: label, accent: accent),
          const SizedBox(height: 12),
          Text(
            value,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: _textPrimary,
              height: 1.3,
            ),
          ),
          if (hint != null) ...[
            const SizedBox(height: 6),
            Text(
              hint!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.4,
                color: _textPrimary.withValues(alpha: 0.46),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
