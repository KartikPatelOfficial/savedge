import 'package:flutter/material.dart';
import '../home/widgets/subscription_plans_widget.dart';
import '../subscription/subscription_purchase_page.dart';
import '../../core/services/subscription_plan_service.dart';
import '../../features/subscription/domain/entities/subscription_plan.dart';
import 'payment_test_page.dart';

/// Demo page to showcase subscription plans widget
class SubscriptionDemoPage extends StatelessWidget {
  const SubscriptionDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plans Demo'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Multiple Subscription Plans (Carousel)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SubscriptionPlansWidget(
              plans: SubscriptionPlanService.getSamplePlans(),
              onPlanTap: (plan) {
                Navigator.of(context).push(
                  SubscriptionPurchasePage.route(plan),
                );
              },
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Single Subscription Plan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SubscriptionPlansWidget(
              plans: [SubscriptionPlanService.getSinglePlan()],
              onPlanTap: (plan) {
                Navigator.of(context).push(
                  SubscriptionPurchasePage.route(plan),
                );
              },
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Plans Without Images (Fallback Design)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SubscriptionPlansWidget(
              plans: SubscriptionPlanService.getSamplePlans()
                  .map((plan) => SubscriptionPlan(
                        id: plan.id,
                        name: plan.name,
                        description: plan.description,
                        price: plan.price,
                        durationMonths: plan.durationMonths,
                        bonusPoints: plan.bonusPoints,
                        maxCoupons: plan.maxCoupons,
                        features: plan.features,
                        imageUrl: null, // Remove image to show fallback
                        isActive: plan.isActive,
                      ))
                  .toList(),
              onPlanTap: (plan) {
                Navigator.of(context).push(
                  SubscriptionPurchasePage.route(plan),
                );
              },
            ),
            const SizedBox(height: 40),
            
            // Payment Test Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment Integration Test',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PaymentTestPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.payment),
                      label: const Text('Test Razorpay Payment'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
