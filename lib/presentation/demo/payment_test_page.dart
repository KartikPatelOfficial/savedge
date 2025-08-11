import 'package:flutter/material.dart';
import '../../features/subscription/domain/entities/subscription_plan.dart';
import '../subscription/subscription_purchase_page.dart';

/// Demo page to test Razorpay payment integration
class PaymentTestPage extends StatelessWidget {
  const PaymentTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final testPlan = SubscriptionPlan(
      id: 1,
      name: 'Premium Plan',
      description: 'Test premium plan for Razorpay integration',
      price: 99.0,
      durationMonths: 1,
      bonusPoints: 100,
      maxCoupons: 5,
      features: 'Test features',
      imageUrl: null,
      isActive: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Test'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Test Razorpay Integration',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Plan: ${testPlan.name}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Price: ₹${testPlan.price}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          SubscriptionPurchasePage.route(testPlan),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: const Text('Test Purchase'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
