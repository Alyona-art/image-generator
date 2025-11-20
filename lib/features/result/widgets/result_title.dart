import 'package:flutter/material.dart';

import '../../../core/extensions/theme_extension.dart';

class ResultTitle extends StatelessWidget {
  const ResultTitle({super.key, required this.prompt});

  final String prompt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prompt:',
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2),
          Text(prompt, style: context.textTheme.headlineMedium),
        ],
      ),
    );
  }
}
