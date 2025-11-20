import 'package:flutter/material.dart';

import '../../../core/widgets/loading_indicator.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: LoadingIndicator());
  }
}
