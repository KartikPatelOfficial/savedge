import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../bloc/brand_vouchers_bloc.dart';
import '../widgets/brand_voucher_card.dart';
import '../widgets/brand_voucher_loading.dart';

class BrandVouchersPage extends StatelessWidget {
  const BrandVouchersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<BrandVouchersBloc>()..add(const LoadBrandVouchers()),
      child: const BrandVouchersView(),
    );
  }
}

class BrandVouchersView extends StatefulWidget {
  const BrandVouchersView({super.key});

  @override
  State<BrandVouchersView> createState() => _BrandVouchersViewState();
}

class _BrandVouchersViewState extends State<BrandVouchersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BrandVouchersBloc>().add(const RefreshBrandVouchers());
          await Future.delayed(const Duration(seconds: 1));
        },
        child: BlocBuilder<BrandVouchersBloc, BrandVouchersState>(
          builder: (context, state) {
            if (state is BrandVouchersLoading) {
              return _buildLoadingView();
            } else if (state is BrandVouchersLoaded) {
              if (state.vouchers.isEmpty) {
                return _buildEmptyStateView();
              }
              return _buildVouchersView(context, state.vouchers);
            } else if (state is BrandVouchersError) {
              return _buildErrorStateView(context, state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildVouchersView(BuildContext context, List vouchers) {
    return CustomScrollView(
      slivers: [
        // Custom App Bar like Profile Page
        SliverAppBar(
          expandedHeight: 140,
          pinned: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.arrow_back_ios_rounded, size: 24),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'Brand Vouchers',
              style: TextStyle(
                color: Color(0xFF1A202C),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            titlePadding: const EdgeInsets.only(left: 20),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.receipt_long_rounded,
                  color: Color(0xFF6F3FCC),
                ),
                onPressed: () => _showVoucherOrdersPage(context),
              ),
            ),
          ],
        ),

        // Vouchers Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: vouchers.length,
              itemBuilder: (context, index) {
                return BrandVoucherCard(
                  voucher: vouchers[index],
                  onTap: () => _showVoucherDetails(context, vouchers[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingView() {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        const SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: BrandVoucherLoading(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyStateView() {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6F3FCC).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.card_giftcard_rounded,
                      size: 48,
                      color: Color(0xFF6F3FCC),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'No Vouchers Available',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A202C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Check back later for exciting voucher offers',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4A5568),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorStateView(BuildContext context, String message) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE53E3E).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Color(0xFFE53E3E),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Something went wrong',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A202C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4A5568),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BrandVouchersBloc>().add(
                        const LoadBrandVouchers(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6F3FCC),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      backgroundColor: Colors.white,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A202C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(color: Colors.white),
        title: const Text(
          'Brand Vouchers',
          style: TextStyle(
            color: Color(0xFF1A202C),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF6F3FCC).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.receipt_long_rounded,
              color: Color(0xFF6F3FCC),
            ),
            onPressed: () => _showVoucherOrdersPage(context),
          ),
        ),
      ],
    );
  }

  void _showVoucherDetails(BuildContext context, dynamic voucher) {
    // Navigate to voucher purchase page
    // This will be implemented next
    Navigator.pushNamed(context, '/voucher-purchase', arguments: voucher);
  }

  void _showVoucherOrdersPage(BuildContext context) {
    // Navigate to voucher orders page
    // This will be implemented next
    Navigator.pushNamed(context, '/voucher-orders');
  }
}
