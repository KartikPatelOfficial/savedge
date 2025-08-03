# Enhanced Authentication Flow Implementation

## Overview
This implementation provides a comprehensive authentication flow that supports both individual users and employees from organizations, with Firebase phone verification as the primary authentication method.

## Key Features

### 1. Firebase Phone Authentication
- **OTP Verification**: Users authenticate using their phone number via Firebase Auth
- **Security**: Firebase handles the OTP generation and verification process
- **Multi-country Support**: Supports international phone numbers with country codes

### 2. Dual User Types
- **Individual Users**: Regular users who sign up independently
- **Employee Users**: Users who are part of an organization and have additional benefits

### 3. Organization Employee Management
- **Pre-registration**: Organizations can add employees to the system before they sign up
- **Employee Detection**: When employees sign up, the system automatically detects their employee status
- **Organization Changes**: Employees can change organizations (e.g., when changing jobs)

### 4. Enhanced User Experience
- **Employee Welcome Dialog**: Shows organization details and employee information on first login
- **Organization Change Page**: Allows employees to request organization changes
- **Seamless Flow**: Automatic detection and appropriate routing based on user type

## Implementation Details

### Models and Entities

#### UserExistsResult
```dart
class UserExistsResult {
  const UserExistsResult({
    required this.exists,
    this.user,
    this.isEmployee = false,
  });

  final bool exists;
  final User? user;
  final bool isEmployee;
}
```

#### Enhanced User Entity
The User entity now includes employee-specific fields:
- `isEmployee`: Boolean flag indicating if user is an employee
- `employeeCode`: Unique employee identifier
- `department`: Employee's department
- `position`: Employee's job position
- `joinDate`: When the employee joined the organization

### API Integration

#### User Existence Check
- **Endpoint**: `/api/users/check-exists`
- **Response**: Returns user existence status and profile data if user exists
- **Employee Data**: Includes organization and employee-specific information

#### User Registration
- **Endpoint**: `/api/users/register`
- **Individual Users**: Creates a new user profile
- **Employees**: Links to existing employee data created by organization

### Authentication Flow

#### 1. Phone Number Entry
```dart
// User enters phone number and country code
SendOtpEvent(
  phoneNumber: phoneNumber,
  countryCode: countryCode,
)
```

#### 2. OTP Verification
```dart
// User enters the 6-digit OTP
VerifyOtpEvent(
  verificationId: verificationId,
  otp: otp,
)
```

#### 3. User Existence Check
```dart
// System checks if user exists in backend
CheckUserExistsEvent()

// Returns UserExistsResult with user data
```

#### 4. User Type Handling
- **New Users**: Redirect to registration/setup page
- **Existing Individual Users**: Sync profile and go to home
- **Existing Employees**: Show welcome dialog, then sync and go to home

#### 5. Employee Welcome Experience
```dart
// Show employee welcome dialog with organization details
EmployeeWelcomeDialog(
  user: employeeUser,
  onContinue: () {
    // Sync profile and continue to home
  },
)
```

### State Management

#### Authentication States
- `AuthUserExists`: Enhanced to include `isEmployee` flag and `user` data
- `AuthUserNotExists`: User needs to register
- `AuthFirebaseSuccess`: Firebase authentication completed
- `AuthSyncSuccess`: Profile sync completed

#### BLoC Events
- `SendOtpEvent`: Request OTP for phone number
- `VerifyOtpEvent`: Verify OTP code
- `CheckUserExistsEvent`: Check if user exists in backend
- `SyncUserProfileEvent`: Sync user profile data

### UI Components

#### OTP Verification Page
- Enhanced to handle employee welcome dialog
- Automatic user type detection and routing
- Error handling and retry functionality

#### Employee Welcome Dialog
- Shows organization information
- Displays employee details (ID, department, position)
- Points balance and program information
- Engaging welcome experience

#### Organization Change Page
- Form for requesting organization changes
- Current organization details display
- New organization information input
- Approval workflow information

## API Endpoints Used

### Authentication Endpoints
- `POST /api/users/check-exists` - Check if user exists
- `POST /api/users/register` - Register new user
- `POST /api/auth/sync` - Sync user profile
- `GET /api/users/profile` - Get user profile

### Organization Management
- `POST /api/users/{userId}/change-organization` - Request organization change
- `POST /api/users/{userId}/remove-from-organization` - Remove from organization

## Employee Lifecycle

### 1. Organization Adds Employee
- Admin adds employee to organization database
- Employee data includes: email, employee code, department, position
- Employee status is set but user account is not yet created

### 2. Employee Signs Up
- Employee uses phone number to sign up
- System matches employee by email (from Firebase user data)
- Employee is automatically linked to organization
- Welcome dialog shows organization details

### 3. Organization Changes
- Employee can request to change organizations
- New organization must approve the request
- Employee data is transferred to new organization
- Points and history are maintained

## Security Considerations

### Firebase Authentication
- Secure OTP generation and verification
- Rate limiting on OTP requests
- Phone number verification ensures ownership

### Backend Validation
- User existence checks prevent unauthorized access
- Employee status validation ensures proper organization linking
- Token validation for API requests

### Data Privacy
- Employee data is only accessible to authorized organizations
- User consent for data sharing between organizations
- Audit trail for organization changes

## Future Enhancements

### Planned Features
1. **Multiple Organization Support**: Allow employees to be part of multiple organizations
2. **Role-based Permissions**: Different access levels within organizations
3. **Notification System**: Real-time notifications for organization changes
4. **Analytics Dashboard**: Organization-wide employee engagement metrics

### Technical Improvements
1. **Offline Support**: Cache user data for offline access
2. **Biometric Authentication**: Add fingerprint/face ID support
3. **Social Login**: Support for Google/Apple sign-in
4. **Advanced Security**: Multi-factor authentication options

## Testing Strategy

### Unit Tests
- Authentication use cases
- User existence validation
- Employee data transformation

### Integration Tests
- Firebase authentication flow
- API endpoint integration
- State management validation

### E2E Tests
- Complete authentication flow
- Employee welcome experience
- Organization change process

This implementation provides a robust foundation for a dual-user authentication system that can scale to support multiple organizations and thousands of employees while maintaining a smooth user experience.
