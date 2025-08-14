import 'package:flutter_test/flutter_test.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';

void main() {
  group('UserCouponModel Tests', () {
    test('should parse API response correctly', () {
      // Sample response from API
      const apiResponse = {
        'id': 2,
        'couponId': 1,
        'title': '20% Off',
        'vendorId': 4,
        'status': 'Unused',
        'acquiredDate': '2025-08-14T01:44:49.6723144',
        'redeemedDate': null,
        'expiryDate': '2025-10-08T00:00:00',
        'uniqueCode': 'SE-BC80E3934B',
        'qrCode': null,
        'discountType': 'Percentage',
        'discountValue': 10.0,
        'imageUrl': null,
      };

      final coupon = UserCouponModel.fromJson(apiResponse);

      expect(coupon.id, 2);
      expect(coupon.couponId, 1);
      expect(coupon.title, '20% Off');
      expect(coupon.vendorId, 4);
      expect(coupon.isUsed, false); // status is 'Unused'
      expect(coupon.discountType, 'Percentage');
      expect(coupon.discountValue, 10.0);
      expect(coupon.discountDisplay, '10% Off');
      expect(coupon.redemptionCode, 'SE-BC80E3934B');
      expect(coupon.isValid, true); // not used and not expired
    });

    test('should handle used coupon correctly', () {
      const apiResponse = {
        'id': 1,
        'couponId': 1,
        'title': '20% Off',
        'vendorId': 4,
        'status': 'Used',
        'acquiredDate': '2025-08-14T01:44:49.6723144',
        'redeemedDate': '2025-08-15T10:30:00.0000000',
        'expiryDate': '2025-10-08T00:00:00',
        'uniqueCode': 'SE-BC80E3934B',
        'qrCode': null,
        'discountType': 'Percentage',
        'discountValue': 15.0,
        'imageUrl': null,
      };

      final coupon = UserCouponModel.fromJson(apiResponse);

      expect(coupon.isUsed, true); // status is 'Used'
      expect(coupon.usedAt, '2025-08-15T10:30:00.0000000');
      expect(coupon.isValid, false); // used coupon is not valid
      expect(coupon.statusText, 'Used');
      expect(coupon.discountDisplay, '15% Off');
    });

    test('should handle fixed amount discount correctly', () {
      const apiResponse = {
        'id': 3,
        'couponId': 2,
        'title': 'Fixed Amount Off',
        'vendorId': 5,
        'status': 'Unused',
        'acquiredDate': '2025-08-14T01:44:49.6723144',
        'redeemedDate': null,
        'expiryDate': '2025-10-08T00:00:00',
        'uniqueCode': 'SE-ABC123',
        'qrCode': null,
        'discountType': 'FixedAmount',
        'discountValue': 50.0,
        'imageUrl': null,
      };

      final coupon = UserCouponModel.fromJson(apiResponse);

      expect(coupon.discountType, 'FixedAmount');
      expect(coupon.discountValue, 50.0);
      expect(coupon.discountDisplay, '₹50 Off');
    });

    test('should detect expired coupon', () {
      const apiResponse = {
        'id': 4,
        'couponId': 3,
        'title': 'Expired Coupon',
        'vendorId': 6,
        'status': 'Unused',
        'acquiredDate': '2025-01-01T00:00:00.0000000',
        'redeemedDate': null,
        'expiryDate': '2025-01-15T00:00:00', // Expired
        'uniqueCode': 'SE-EXPIRED',
        'qrCode': null,
        'discountType': 'Percentage',
        'discountValue': 25.0,
        'imageUrl': null,
      };

      final coupon = UserCouponModel.fromJson(apiResponse);

      expect(coupon.isExpired, true);
      expect(coupon.isValid, false); // expired coupon is not valid
      expect(coupon.statusText, 'Expired');
    });
  });
}
