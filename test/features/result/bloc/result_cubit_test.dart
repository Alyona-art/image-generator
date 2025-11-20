import 'package:flutter_test/flutter_test.dart';
import 'package:generate_test_app/core/repository/generation_repository.dart';
import 'package:generate_test_app/features/result/bloc/result_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGenerationRepository extends Mock implements GenerationRepository {}

void main() {
  group('ResultCubit', () {
    late MockGenerationRepository mockRepository;

    setUp(() {
      mockRepository = MockGenerationRepository();
      registerFallbackValue('');
    });

    test('initial state has correct prompt and initial status', () {
      const prompt = 'test prompt';
      final cubit = ResultCubit(repository: mockRepository, prompt: prompt);

      expect(cubit.state.prompt, prompt);
      expect(cubit.state.status, ResultStatus.initial);
      expect(cubit.state.imageUrl, isNull);
    });

    test('generate emits loading then success with imageUrl', () async {
      when(
        () => mockRepository.generate(any()),
      ).thenAnswer((_) async => 'https://example.com/image.jpg');

      final cubit = ResultCubit(
        repository: mockRepository,
        prompt: 'test prompt',
      );

      expect(cubit.state.status, ResultStatus.initial);

      // Use expectLater to capture state changes
      expectLater(
        cubit.stream,
        emitsInOrder([
          const ResultState(
            prompt: 'test prompt',
            status: ResultStatus.loading,
            imageUrl: null,
          ),
          const ResultState(
            prompt: 'test prompt',
            status: ResultStatus.success,
            imageUrl: 'https://example.com/image.jpg',
          ),
        ]),
      );

      await cubit.generate();

      verify(() => mockRepository.generate('test prompt')).called(1);
    });

    test('generate emits loading then failure on exception', () async {
      when(
        () => mockRepository.generate(any()),
      ).thenThrow(Exception('Generation failed'));

      final cubit = ResultCubit(
        repository: mockRepository,
        prompt: 'test prompt',
      );

      expect(cubit.state.status, ResultStatus.initial);

      // Use expectLater to capture state changes
      expectLater(
        cubit.stream,
        emitsInOrder([
          const ResultState(
            prompt: 'test prompt',
            status: ResultStatus.loading,
            imageUrl: null,
          ),
          const ResultState(
            prompt: 'test prompt',
            status: ResultStatus.failure,
          ),
        ]),
      );

      await cubit.generate();

      verify(() => mockRepository.generate('test prompt')).called(1);
    });

    test(
      'generate clears previous imageUrl when starting new generation',
      () async {
        when(
          () => mockRepository.generate(any()),
        ).thenAnswer((_) async => 'https://example.com/new-image.jpg');

        final cubit = ResultCubit(
          repository: mockRepository,
          prompt: 'test prompt',
        );

        // Simulate previous success state
        cubit.emit(
          const ResultState(
            prompt: 'test prompt',
            status: ResultStatus.success,
            imageUrl: 'https://example.com/old-image.jpg',
          ),
        );

        final generateFuture = cubit.generate();

        // Check loading state clears imageUrl
        expect(cubit.state.status, ResultStatus.loading);
        expect(cubit.state.imageUrl, isNull);

        await generateFuture;

        // Check new success state
        expect(cubit.state.status, ResultStatus.success);
        expect(cubit.state.imageUrl, 'https://example.com/new-image.jpg');
      },
    );
  });
}
