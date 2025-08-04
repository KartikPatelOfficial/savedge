import 'package:equatable/equatable.dart';

import '../../domain/entities/vendor.dart';

abstract class VendorsState extends Equatable {
  const VendorsState();

  @override
  List<Object?> get props => [];
}

class VendorsInitial extends VendorsState {}

class VendorsLoading extends VendorsState {}

class VendorsLoaded extends VendorsState {
  const VendorsLoaded({
    required this.vendors,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.searchTerm,
    this.selectedCategory,
  });

  final List<Vendor> vendors;
  final bool hasReachedMax;
  final int currentPage;
  final String? searchTerm;
  final String? selectedCategory;

  VendorsLoaded copyWith({
    List<Vendor>? vendors,
    bool? hasReachedMax,
    int? currentPage,
    String? searchTerm,
    String? selectedCategory,
  }) {
    return VendorsLoaded(
      vendors: vendors ?? this.vendors,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      searchTerm: searchTerm ?? this.searchTerm,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [
    vendors,
    hasReachedMax,
    currentPage,
    searchTerm,
    selectedCategory,
  ];
}

class VendorsError extends VendorsState {
  const VendorsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
