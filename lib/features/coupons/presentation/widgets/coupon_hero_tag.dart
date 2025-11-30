/// Builds a consistent Hero tag for coupon surfaces across the app.
String couponHeroTag({
  required int couponId,
  int? userCouponId,
  String? source,
}) {
  final parts = ['coupon', 'hero', couponId.toString()];

  if (userCouponId != null) {
    parts.add('user$userCouponId');
  }

  if (source != null && source.isNotEmpty) {
    parts.add(source);
  }

  return parts.join('-');
}
