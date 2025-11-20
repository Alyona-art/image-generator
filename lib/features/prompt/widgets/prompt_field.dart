import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generate_test_app/core/extensions/theme_extension.dart';

import '../bloc/prompt_cubit.dart';

class PromptField extends StatefulWidget {
  const PromptField({super.key});

  @override
  State<PromptField> createState() => _PromptFieldState();
}

class _PromptFieldState extends State<PromptField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initialValue = context.read<PromptCubit>().state.value;
    _controller = TextEditingController(text: initialValue);
    _controller.addListener(_onPromptChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onPromptChanged)
      ..dispose();
    super.dispose();
  }

  void _onPromptChanged() {
    context.read<PromptCubit>().updatePrompt(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      minLines: 1,
      maxLines: 5,
      style: TextStyle(color: context.colorScheme.onSurface, fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colorScheme.surfaceContainerLow,
        hintText: 'Describe what you want to see…',
        hintStyle: TextStyle(
          color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: context.colorScheme.primary.withValues(alpha: 0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: context.colorScheme.primary.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: context.colorScheme.primary),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.close),
          iconSize: 20,
          onPressed: () {
            _controller.clear();
          },
        ),
      ),
    );
  }
}
