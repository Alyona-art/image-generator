import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generate_test_app/core/extensions/theme_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:generate_test_app/features/result/widgets/result_title.dart';

import '../../core/di/injection.dart';
import 'bloc/result_cubit.dart';
import 'widgets/error_view.dart';
import 'widgets/loading_view.dart';
import 'widgets/success_view.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.prompt});

  final String prompt;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ResultCubit>(param1: prompt)..generate(),
      child: const ResultView(),
    );
  }
}

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultCubit, ResultState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.only(bottom: 128),
                    children: [
                      ResultTitle(prompt: state.prompt),
                      Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: switch (state.status) {
                            ResultStatus.loading => _AspectRatioWrapper(
                              key: const ValueKey('loading'),
                              child: const LoadingView(),
                            ),
                            ResultStatus.success => _AspectRatioWrapper(
                              key: const ValueKey('success'),
                              child: SuccessView(imageUrl: state.imageUrl!),
                            ),
                            ResultStatus.failure => _AspectRatioWrapper(
                              key: const ValueKey('error'),
                              child: const ErrorView(),
                            ),
                            _ => const SizedBox.shrink(key: ValueKey('empty')),
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                        onPressed: () => context.read<ResultCubit>().generate(),
                        child: const Text('Try another'),
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: () => context.pop(),
                        child: const Text('New prompt'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AspectRatioWrapper extends StatelessWidget {
  const _AspectRatioWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1, child: child);
  }
}
