import 'package:equatable/equatable.dart';

class FavoriteVendor extends Equatable {
  const FavoriteVendor({
    required this.id,
    required this.vendorId,
    required this.businessName,
    required this.category,
    this.description,
    this.imageUrl,
    this.address,
    this.city,
    this.state,
    required this.addedAt,
  });

  final String id;
  final int vendorId;
  final String businessName;
  final String category;
  final String? description;
  final String? imageUrl;
  final String? address;
  final String? city;
  final String? state;
  final DateTime addedAt;

  @override
  List<Object?> get props => [
        id,
        vendorId,
        businessName,
        category,
        description,
        imageUrl,
        address,
        city,
        state,
        addedAt,
      ];
}