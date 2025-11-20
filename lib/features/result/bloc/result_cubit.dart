import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/repository/generation_repository.dart';

part 'result_cubit.freezed.dart';

enum ResultStatus { initial, loading, success, failure }

@freezed
class ResultState with _$ResultState {
  const factory ResultState({
    required String prompt,
    @Default(ResultStatus.initial) ResultStatus status,
    String? imageUrl,
  }) = _ResultState;

  const ResultState._();
}

@injectable
class ResultCubit extends Cubit<ResultState> {
  ResultCubit({
    required GenerationRepository repository,
    @factoryParam required String prompt,
  }) : _repository = repository,
       super(ResultState(prompt: prompt));

  final GenerationRepository _repository;

  Future<void> generate() async {
    emit(state.copyWith(status: ResultStatus.loading, imageUrl: null));

    try {
      final imageUrl = await _repository.generate(state.prompt);
      emit(state.copyWith(status: ResultStatus.success, imageUrl: imageUrl));
    } catch (_) {
      emit(state.copyWith(status: ResultStatus.failure));
    }
  }
}
