import 'package:face_detection_application/subscription_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class TrialManager {
  static const _trialKey = 'trialCount';

  /// Initialize trial count on first launch
  static Future<void> initTrials() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_trialKey)) {
      await prefs.setInt(_trialKey, 15); // 10 free trials
    }
  }

  /// Check and use one trial
  static Future<bool> useTrial(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    int trials = prefs.getInt(_trialKey) ?? 0;

    if (trials > 0) {
      await prefs.setInt(_trialKey, trials - 1);
      return true; // allow usage
    } else {
      _showLimitDialog(context);
      return false; // block usage
    }
  }

  static void _showLimitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Limit Reached"),
            content: Text(
              "You've used all 10 free trials. Please subscribe to continue.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SubscriptionScreen()),
                  );
                },
                child: Text("Subscribe"),
              ),
            ],
          ),
    );
  }
}
