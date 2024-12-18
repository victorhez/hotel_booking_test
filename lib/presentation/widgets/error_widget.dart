import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const CustomErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Something went wrong."),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(onPressed: onRetry, child: const Text("Retry")),
      ],
    );
  }
}
