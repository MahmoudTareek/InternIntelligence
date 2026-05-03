import 'package:face_detection_application/Shared/Subscription_manager.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Subscribe")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, size: 80, color: Colors.orange),
              const SizedBox(height: 20),
              const Text(
                "You’ve used your 10 free trials.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Unlock unlimited access by subscribing.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () async {
                  await SubscriptionManager.subscribe();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("You are now subscribed! 🎉")),
                  );

                  Navigator.pop(context); // أو روح على الشاشة الأساسية
                },
                icon: Icon(Icons.payment),
                label: Text("Subscribe Now"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
