import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/brand_voucher_entity.dart';
import '../../domain/repositories/brand_voucher_repository.dart';
import '../../domain/usecases/get_brand_vouchers_usecase.dart';
import '../../domain/usecases/create_voucher_order_usecase.dart';
import '../../domain/usecases/get_voucher_orders_usecase.dart';

part 'brand_vouchers_event.dart';
part 'brand_vouchers_state.dart';

@injectable
class BrandVouchersBloc extends Bloc<BrandVouchersEvent, BrandVouchersState> {
  final GetBrandVouchersUseCase getBrandVouchersUseCase;
  final CreateVoucherOrderUseCase createVoucherOrderUseCase;
  final GetVoucherOrdersUseCase getVoucherOrdersUseCase;
  final BrandVoucherRepository brandVoucherRepository;

  BrandVouchersBloc({
    required this.getBrandVouchersUseCase,
    required this.createVoucherOrderUseCase,
    required this.getVoucherOrdersUseCase,
    required this.brandVoucherRepository,
  }) : super(BrandVouchersInitial()) {
    on<LoadBrandVouchers>(_onLoadBrandVouchers);
    on<RefreshBrandVouchers>(_onRefreshBrandVouchers);
    on<CreateVoucherOrder>(_onCreateVoucherOrder);
    on<LoadVoucherOrders>(_onLoadVoucherOrders);
    on<CreateRazorpayOrder>(_onCreateRazorpayOrder);
    on<VerifyRazorpayPayment>(_onVerifyRazorpayPayment);
  }

  Future<void> _onLoadBrandVouchers(
    LoadBrandVouchers event,
    Emitter<BrandVouchersState> emit,
  ) async {
    emit(BrandVouchersLoading());

    final result = await getBrandVouchersUseCase(
      GetBrandVouchersParams(
        isActive: event.isActive,
        searchTerm: event.searchTerm,
      ),
    );

    result.fold(
      (failure) => emit(BrandVouchersError(failure.toString())),
      (vouchers) => emit(BrandVouchersLoaded(vouchers)),
    );
  }

  Future<void> _onRefreshBrandVouchers(
    RefreshBrandVouchers event,
    Emitter<BrandVouchersState> emit,
  ) async {
    // Don't show loading for refresh
    final result = await getBrandVouchersUseCase(
      const GetBrandVouchersParams(),
    );

    result.fold(
      (failure) => emit(BrandVouchersError(failure.toString())),
      (vouchers) => emit(BrandVouchersLoaded(vouchers)),
    );
  }

  Future<void> _onCreateVoucherOrder(
    CreateVoucherOrder event,
    Emitter<BrandVouchersState> emit,
  ) async {
    emit(VoucherOrderCreating());

    final result = await createVoucherOrderUseCase(
      CreateVoucherOrderParams(
        userId: event.userId,
        brandVoucherId: event.brandVoucherId,
        voucherAmount: event.voucherAmount,
      ),
    );

    result.fold(
      (failure) => emit(VoucherOrderError(failure.toString())),
      (orderId) => emit(VoucherOrderCreated(orderId)),
    );
  }

  Future<void> _onLoadVoucherOrders(
    LoadVoucherOrders event,
    Emitter<BrandVouchersState> emit,
  ) async {
    emit(VoucherOrdersLoading());

    final result = await getVoucherOrdersUseCase(
      GetVoucherOrdersParams(
        status: event.status,
        pageNumber: event.pageNumber,
        pageSize: event.pageSize,
      ),
    );

    result.fold(
      (failure) => emit(VoucherOrdersError(failure.toString())),
      (orders) => emit(VoucherOrdersLoaded(orders)),
    );
  }

  Future<void> _onCreateRazorpayOrder(
    CreateRazorpayOrder event,
    Emitter<BrandVouchersState> emit,
  ) async {
    emit(RazorpayOrderCreating());

    final result = await brandVoucherRepository.createRazorpayOrder(
      brandVoucherId: event.brandVoucherId,
      voucherAmount: event.voucherAmount,
    );

    result.fold(
      (failure) => emit(RazorpayOrderError(failure.toString())),
      (response) => emit(
        RazorpayOrderCreated(
          orderId: response.orderId,
          amount: response.amount,
          currency: response.currency,
          voucherOrderId: response.voucherOrderId,
          brandName: response.brandName,
          voucherAmount: response.voucherAmount,
          processingFee: response.processingFee,
          totalAmount: response.totalAmount,
          razorpayKey: response.razorpayKey,
        ),
      ),
    );
  }

  Future<void> _onVerifyRazorpayPayment(
    VerifyRazorpayPayment event,
    Emitter<BrandVouchersState> emit,
  ) async {
    emit(RazorpayPaymentVerifying());

    final result = await brandVoucherRepository.verifyRazorpayPayment(
      voucherOrderId: event.voucherOrderId,
      razorpayOrderId: event.razorpayOrderId,
      razorpayPaymentId: event.razorpayPaymentId,
      razorpaySignature: event.razorpaySignature,
    );

    result.fold(
      (failure) => emit(RazorpayPaymentError(failure.toString())),
      (response) => emit(
        RazorpayPaymentVerified(
          voucherOrderId: response.voucherOrderId,
          message: response.message,
        ),
      ),
    );
  }
}