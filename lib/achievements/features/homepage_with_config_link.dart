import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePageWithConfigLink extends StatelessWidget {
  const HomePageWithConfigLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Better Steam Achievements'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "This application requires credentials to function, these can be entered below.",
              style: Theme.of(context).textTheme.bodyLarge!,
            ),
            ElevatedButton(
              child: const Text("Enter Credentials"),
              onPressed: () => context.go('/config'),
            )
          ],
        ),
      ),
    );
  }
}
