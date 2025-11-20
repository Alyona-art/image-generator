import 'package:flutter_test/flutter_test.dart';
import 'package:generate_test_app/features/prompt/bloc/prompt_cubit.dart';

void main() {
  group('PromptCubit', () {
    test('initial state is empty string', () {
      expect(PromptCubit().state.value, '');
    });

    test('initial state isValid is false', () {
      expect(PromptCubit().state.isValid, false);
    });

    test('updatePrompt emits new state with value', () {
      final cubit = PromptCubit();
      cubit.updatePrompt('test prompt');
      expect(cubit.state.value, 'test prompt');
    });

    test('updatePrompt with whitespace only is not valid', () {
      final cubit = PromptCubit();
      cubit.updatePrompt('   ');
      expect(cubit.state.value, '   ');
      expect(cubit.state.isValid, false);
    });

    test('updatePrompt with non-empty string is valid', () {
      final cubit = PromptCubit();
      cubit.updatePrompt('valid prompt');
      expect(cubit.state.value, 'valid prompt');
      expect(cubit.state.isValid, true);
    });

    test('multiple updatePrompt calls emit correct states', () {
      final cubit = PromptCubit();
      cubit.updatePrompt('first');
      expect(cubit.state.value, 'first');
      cubit.updatePrompt('second');
      expect(cubit.state.value, 'second');
      cubit.updatePrompt('third');
      expect(cubit.state.value, 'third');
    });
  });
}
