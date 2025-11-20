import 'package:flutter/material.dart';
import 'package:generate_test_app/core/extensions/theme_extension.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: CircularProgressIndicator(color: context.colorScheme.primary),
    );
  }
}
