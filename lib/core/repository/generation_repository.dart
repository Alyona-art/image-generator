import 'dart:math';
import 'package:injectable/injectable.dart';

@injectable
class GenerationRepository {
  final Random _random = Random();

  Future<String> generate(String prompt) async {
    final duration = Duration(seconds: 2);
    await Future.delayed(duration);

    final shouldFail = _random.nextBool();
    if (shouldFail) {
      throw Exception('Generation failed');
    }
    final index = _random.nextInt(2000);
    return 'https://github.com/yavuzceliker/sample-images/blob/18f67efa323906d68e497b49ae0163b4b938270b/docs/image-$index.jpg?raw=true';
  }
}
