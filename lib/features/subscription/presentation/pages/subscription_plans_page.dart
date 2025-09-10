import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../../../shared/domain/entities/subscription.dart';
import '../../../../shared/widgets/common_widgets.dart';
import '../bloc/subscription_bloc.dart';
import '../widgets/current_subscription_card.dart';
import '../widgets/purchase_confirmation_dialog.dart';
import '../widgets/subscription_plan_card.dart';

/// Page for displaying subscription plans and managing user subscriptions
class SubscriptionPlansPage extends StatelessWidget {
  static const String routeName = '/subscription-plans';

  const SubscriptionPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SubscriptionBloc>()
        ..add(const LoadSubscriptionPlans())
        ..add(const LoadUserSubscription()),
      child: const _SubscriptionPlansView(),
    );
  }
}

class _SubscriptionPlansView extends StatelessWidget {
  const _SubscriptionPlansView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plans'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<SubscriptionBloc>().add(
                const RefreshSubscriptionData(includePaymentHistory: false),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionLoaded) {
            // Handle success messages
            if (state.purchaseSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Subscription purchased successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            }

            // Handle error messages
            if (state.purchaseError != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.purchaseError!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is SubscriptionLoading) {
            return const LoadingWidget();
          }

          if (state is SubscriptionError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () => context.read<SubscriptionBloc>().add(
                const RefreshSubscriptionData(),
              ),
            );
          }

          if (state is SubscriptionLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<SubscriptionBloc>().add(
                  const RefreshSubscriptionData(),
                );
              },
              child: CustomScrollView(
                slivers: [
                  // Current Subscription Section
                  if (state.hasUserSubscription)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: CurrentSubscriptionCard(
                          subscription: state.userSubscription!,
                          plan: state.currentSubscriptionPlan,
                        ),
                      ),
                    ),

                  // Plans Header
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        'Choose Your Plan',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Subscription Plans Grid
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final plan = state.plans[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SubscriptionPlanCard(
                            plan: plan,
                            isCurrentPlan:
                                state.hasUserSubscription &&
                                state.userSubscription!.planId == plan.id,
                            canPurchase: state.canPurchaseSubscription,
                            onPurchase: () =>
                                _showPurchaseOptions(context, plan, state),
                            isLoading: state.isPurchasing,
                          ),
                        );
                      }, childCount: state.plans.length),
                    ),
                  ),

                  // Benefits Section
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: _BenefitsSection(),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showPurchaseOptions(
    BuildContext context,
    SubscriptionPlan plan,
    SubscriptionLoaded state,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BlocProvider.value(
        value: context.read<SubscriptionBloc>(),
        child: PurchaseConfirmationDialog(
          plan: plan,
          onPurchaseWithCurrency: () => _purchaseWithCurrency(context, plan),
          onPurchaseWithPoints: () => _purchaseWithPoints(context, plan),
        ),
      ),
    );
  }

  void _purchaseWithCurrency(BuildContext context, SubscriptionPlan plan) {
    Navigator.of(context).pop(); // Close bottom sheet

    // For now, use simple purchase (can be extended to use Razorpay later)
    context.read<SubscriptionBloc>().add(
      PurchaseSubscriptionEvent(planId: plan.id),
    );
  }

  void _purchaseWithPoints(BuildContext context, SubscriptionPlan plan) {
    Navigator.of(context).pop(); // Close bottom sheet

    context.read<SubscriptionBloc>().add(
      PurchaseSubscriptionWithPointsEvent(planId: plan.id),
    );
  }
}

/// Section displaying benefits of having a subscription
class _BenefitsSection extends StatelessWidget {
  const _BenefitsSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber[700]),
                const SizedBox(width: 8),
                const Text(
                  'Subscription Benefits',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildBenefitItem(
              icon: Icons.discount,
              title: 'Exclusive Coupons',
              description: 'Access to subscriber-only deals and offers',
            ),
            _buildBenefitItem(
              icon: Icons.priority_high,
              title: 'Priority Support',
              description: 'Get faster customer service response',
            ),
            _buildBenefitItem(
              icon: Icons.notifications_active,
              title: 'Early Access',
              description: 'Be first to know about new deals and vendors',
            ),
            _buildBenefitItem(
              icon: Icons.save_alt,
              title: 'Maximum Savings',
              description: 'Save more with higher coupon limits',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue[100],
            child: Icon(icon, color: Colors.blue[700], size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
