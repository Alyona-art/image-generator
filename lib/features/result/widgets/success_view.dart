import 'package:flutter/material.dart';
import 'package:generate_test_app/features/result/widgets/error_view.dart';

import '../../../core/widgets/loading_indicator.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded || frame != null) {
            return child;
          }

          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 5),
            curve: Curves.easeIn,
            child: child,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: LoadingIndicator());
        },
        errorBuilder: (context, error, stackTrace) => ErrorView(),
      ),
    );
  }
}
