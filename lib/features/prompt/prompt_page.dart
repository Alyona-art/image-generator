import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_routes.dart';
import 'bloc/prompt_cubit.dart';
import 'widgets/prompt_field.dart';

class PromptPage extends StatefulWidget {
  const PromptPage({super.key});

  @override
  State<PromptPage> createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  void _onGeneratePressed() {
    final prompt = context.read<PromptCubit>().state.value.trim();
    if (prompt.isEmpty) return;
    context.push(AppRoutes.resultWithPrompt(prompt));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromptCubit, PromptState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PromptField(),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: FilledButton(
                      onPressed: state.isValid ? _onGeneratePressed : null,
                      child: const Text('Generate'),
                    ),
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
