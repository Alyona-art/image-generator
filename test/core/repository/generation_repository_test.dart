import 'package:flutter_test/flutter_test.dart';
import 'package:generate_test_app/core/repository/generation_repository.dart';

void main() {
  group('GenerationRepository', () {
    late GenerationRepository repository;

    setUp(() {
      repository = GenerationRepository();
    });

    test('generate completes successfully', () async {
      bool success = false;
      for (int i = 0; i < 10; i++) {
        try {
          final result = await repository.generate('test prompt');
          expect(result, isA<String>());
          expect(result, isNotEmpty);
          expect(result, startsWith('https://'));
          success = true;
          break;
        } catch (_) {
          // Continue trying
        }
      }

      expect(success, true);
    });

    test('generate can throw exception', () async {
      bool failure = false;
      for (int i = 0; i < 10; i++) {
        try {
          await repository.generate('test prompt');
        } catch (e) {
          expect(e, isA<Exception>());
          expect(e.toString(), contains('Generation failed'));
          failure = true;
          break;
        }
      }

      expect(failure, true);
    });

    test('generate returns valid URL format on success', () async {
      bool foundValidUrl = false;
      for (int i = 0; i < 10; i++) {
        try {
          final result = await repository.generate('test prompt');
          expect(result, contains('https://'));
          expect(result, contains('.jpg'));
          foundValidUrl = true;
          break;
        } catch (_) {
          // Continue trying
        }
      }
      expect(foundValidUrl, true);
    });

    test('generate takes approximately 2 seconds', () async {
      final stopwatch = Stopwatch()..start();
      try {
        await repository.generate('test prompt');
      } catch (_) {
        // Ignore failures for timing test
      }
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, greaterThan(1800));
      expect(stopwatch.elapsedMilliseconds, lessThan(2500));
    });
  });
}
