import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/theme_extension.dart';
import '../bloc/result_cubit.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.message =
        'Something went wrong while generating your image.\nPlease try again.',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.read<ResultCubit>().generate(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: const Text('Retry'),
            ),
          ),
        ],
      ),
    );
  }
}
