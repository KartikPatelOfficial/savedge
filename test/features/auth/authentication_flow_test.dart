import 'package:flutter_test/flutter_test.dart';
import 'package:savedge/features/auth/domain/usecases/check_user_exists_usecase.dart';

void main() {
  group('Authentication Flow Tests', () {
    test('UserExistsResult should handle employee data correctly', () {
      // Test for individual user
      const individualResult = UserExistsResult(
        exists: true,
        isEmployee: false,
      );

      expect(individualResult.exists, true);
      expect(individualResult.isEmployee, false);
      expect(individualResult.user, null);

      // Test for employee user
      const employeeResult = UserExistsResult(
        exists: true,
        isEmployee: true,
      );

      expect(employeeResult.exists, true);
      expect(employeeResult.isEmployee, true);
    });

    test('UserExistsResult should handle non-existent user', () {
      const nonExistentResult = UserExistsResult(
        exists: false,
      );

      expect(nonExistentResult.exists, false);
      expect(nonExistentResult.isEmployee, false);
      expect(nonExistentResult.user, null);
    });
  });
}
