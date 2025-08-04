import 'package:equatable/equatable.dart';

abstract class VendorsEvent extends Equatable {
  const VendorsEvent();

  @override
  List<Object?> get props => [];
}

class LoadVendors extends VendorsEvent {
  const LoadVendors({
    this.pageNumber = 1,
    this.pageSize = 10,
    this.searchTerm,
    this.category,
    this.refresh = false,
  });

  final int pageNumber;
  final int pageSize;
  final String? searchTerm;
  final String? category;
  final bool refresh;

  @override
  List<Object?> get props => [
    pageNumber,
    pageSize,
    searchTerm,
    category,
    refresh,
  ];
}

class SearchVendors extends VendorsEvent {
  const SearchVendors(this.searchTerm);

  final String searchTerm;

  @override
  List<Object?> get props => [searchTerm];
}

class FilterVendorsByCategory extends VendorsEvent {
  const FilterVendorsByCategory(this.category);

  final String? category;

  @override
  List<Object?> get props => [category];
}

class LoadMoreVendors extends VendorsEvent {
  const LoadMoreVendors();
}

class RefreshVendors extends VendorsEvent {
  const RefreshVendors();
}
